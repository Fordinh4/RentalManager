package com.javaweb.repository.impl;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.repository.custom.BuildingRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;
import java.util.stream.Collectors;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    private void querySqlJoin(BuildingSearchRequest buildingSearchRequest, StringBuilder join) {
        // Handle staffId
        Long staffId = buildingSearchRequest.getStaffId();
        if (staffId != null) {
            join.append(" JOIN assignmentbuilding ab ON b.id = ab.buildingid ");
        }

        // Handle rentArea
        // K cần join rentarea table do đã dùng EXIST
    }

    private void querySqlNormal(BuildingSearchRequest buildingSearchRequest, StringBuilder where) {
        try {
            // Use reflection to access private fields
            Field[] fields = buildingSearchRequest.getClass().getDeclaredFields();

            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();

                if (!fieldName.equals("staffId") && !fieldName.equals("typeCode")
                        && !fieldName.startsWith("rentArea") && !fieldName.startsWith("rentPrice")) {
                    Object value = item.get(buildingSearchRequest);

                    if (value != null && value != "") {
                        if (value instanceof Long || value instanceof Integer) {
                            where.append(" AND b.").append(fieldName.toLowerCase()).append(" = ").append(value);
                        } else if (value instanceof String) {
                            where.append(" AND b.").append(fieldName.toLowerCase()).append(" LIKE '%").append(value).append("%' ");
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void querySqlSpecial(BuildingSearchRequest buildingSearchRequest, StringBuilder where) {
        // Handle areaFrom and areaTo
        Long rentAreaFrom = buildingSearchRequest.getRentAreaFrom();
        Long rentAreaTo = buildingSearchRequest.getRentAreaTo();

        if (rentAreaFrom != null || rentAreaTo != null) {
            where.append(" AND EXISTS (SELECT * FROM rentarea rt WHERE b.id = rt.buildingid ");

            if (rentAreaFrom != null) {
                where.append(" AND rt.value >=" + rentAreaFrom);
            }
            if (rentAreaTo != null) {
                where.append(" AND rt.value <=" + rentAreaTo);
            }
            where.append(") ");
        }

        // Handle staffId
        Long staffId = buildingSearchRequest.getStaffId();
        if (staffId != null) {
            where.append(" AND ab.staffId = " + staffId);
        }

        // Handle rentPrice
        Long rentPriceFrom = buildingSearchRequest.getRentPriceFrom();
        Long rentPriceTo = buildingSearchRequest.getRentPriceTo();
        if (rentPriceFrom != null || rentPriceTo != null) {
            if (rentPriceFrom != null) {
                where.append(" AND b.rentprice >=" + rentPriceFrom);
            }
            if (rentPriceTo != null) {
                where.append(" AND b.rentprice <=" + rentPriceTo);
            }
        }

        // Handle typeCode
        List<String> typeCode = buildingSearchRequest.getTypeCode();
        if (typeCode != null && !typeCode.isEmpty()) {
            where.append(" AND (");
            where.append(typeCode.stream()
                    .map(item -> " b.type LIKE '%" + item + "%'")
                    .collect(Collectors.joining(" OR ")));
            where.append(") ");
        }
    }

    @Override
    public Page<BuildingEntity> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT b.* FROM building b ");
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        querySqlJoin(buildingSearchRequest, sql);
        querySqlNormal(buildingSearchRequest, where);
        querySqlSpecial(buildingSearchRequest, where);

        sql.append(where).append(" GROUP BY b.id ");
        sql.append(" LIMIT ").append(pageable.getPageSize()).append(" OFFSET ").append(pageable.getOffset());

        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);
        List<BuildingEntity> buildingEntities = query.getResultList();

        Integer total = countTotalItems(buildingSearchRequest);

        return new PageImpl<>(buildingEntities, pageable, total);
    }

    @Override
    public Integer countTotalItems(BuildingSearchRequest buildingSearchRequest) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(DISTINCT b.id) FROM building b ");
        StringBuilder where = new StringBuilder(" WHERE 1=1 ");
        querySqlJoin(buildingSearchRequest, sql);
        querySqlNormal(buildingSearchRequest, where);
        querySqlSpecial(buildingSearchRequest, where);

        sql.append(where);
    
        Query query = entityManager.createNativeQuery(sql.toString());
        return ((Number) query.getSingleResult()).intValue();
    }


}
