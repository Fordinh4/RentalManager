package com.javaweb.repository.custom;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.model.request.BuildingSearchRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface BuildingRepositoryCustom {
    Page<BuildingEntity> findBuildings(BuildingSearchRequest buildingSearchRequest, Pageable pageable);

    Integer countTotalItems(BuildingSearchRequest buildingSearchRequest);
}
