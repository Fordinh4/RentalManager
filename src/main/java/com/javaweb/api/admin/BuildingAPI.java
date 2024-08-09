package com.javaweb.api.admin;

import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.impl.BuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/buildings")
public class BuildingAPI {

    @Autowired
    private BuildingService buildingService;

    @PostMapping
    public String createBuilding(@RequestBody BuildingDTO buildingDTO) {
        return buildingService.createOrUpdateBuilding(buildingDTO);
    }

    @DeleteMapping("/{ids}") //@PathVariable để nhận mấy cái id dạng /api/buildings/2,4,5,6,1
    public void deleteBuilding(@PathVariable List<Long> ids) {
        buildingService.deleteBuildings(ids);
    }

    @GetMapping("/{buildingId}/staffs")
    public ResponseDTO getAllStaffs(@PathVariable Long buildingId) {
        return buildingService.getAllStaffs(buildingId);
    }

    @PostMapping("/staffs")
    public String updateAssignmentBuilding(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO) {
        return buildingService.updateAssignmentBuilding(assignmentBuildingDTO);

    }
}
