package com.javaweb.converter;

import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.enums.district;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.repository.RentAreaRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Component // để nó biết là bean?
public class BuildingConverter {
    @Autowired
    RentAreaRepository rentAreaRepository;
    @Autowired
    private ModelMapper modelMapper;

    public BuildingSearchResponse BuildingResponseDTO(BuildingEntity building) {
        BuildingSearchResponse dto = modelMapper.map(building, BuildingSearchResponse.class); // Tự map với column bên BuildingResponseDTO
        dto.setAddress(building.getStreet() + ", " + building.getWard() + ", " + district.getDistrictNameByCode(building.getDistrict()));
        dto.setRentArea(building.getRentAreas().stream()
                .map(rentArea -> String.valueOf(rentArea.getValue()))
                .collect(Collectors.joining(",")));
        return dto;
    }

    public BuildingEntity DTOtoBuildingEntity(BuildingDTO buildingDTO) {
        // Map basic info
        BuildingEntity buildingEntity = modelMapper.map(buildingDTO, BuildingEntity.class);
        List<String> typeCode = buildingDTO.getTypeCode();
        buildingEntity.setType(String.join(",", typeCode));
        buildingEntity.setImage(buildingDTO.getImage());
        return buildingEntity;
    }

    public BuildingDTO BuildingEntityToDTO(BuildingEntity buildingEntity) {
        BuildingDTO dto = modelMapper.map(buildingEntity, BuildingDTO.class);

        if (buildingEntity.getType() != null && !buildingEntity.getType().isEmpty()) {
            dto.setTypeCode(Arrays.asList(buildingEntity.getType().split(",")));
        }
        // Convert rent areas
        if (buildingEntity.getRentAreas() != null && !buildingEntity.getRentAreas().isEmpty()) {
            String rentArea = buildingEntity.getRentAreas().stream()
                    .map(RentAreaEntity::getValue)
                    .map(String::valueOf)
                    .collect(Collectors.joining(", "));
            dto.setRentArea(rentArea);
        }
        return dto;
    }
}
