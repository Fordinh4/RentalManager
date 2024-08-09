package com.javaweb.service;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface IBuildingService {
    List<BuildingSearchResponse> getBuildingSearchResponses(BuildingSearchRequest buildingSearchRequest, Pageable pageable);

    String createOrUpdateBuilding(BuildingDTO buildingDTO);

    BuildingDTO editBuilding(Long id);

    void deleteBuildings(List<Long> ids);

    ResponseDTO getAllStaffs(Long buildingId);

    String updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO);

    Integer countTotalItems(BuildingSearchRequest buildingSearchRequest);
}
