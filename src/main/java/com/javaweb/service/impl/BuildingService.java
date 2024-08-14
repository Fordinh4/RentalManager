package com.javaweb.service.impl;

import com.javaweb.converter.BuildingConverter;
import com.javaweb.entity.BuildingEntity;
import com.javaweb.entity.RentAreaEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentBuildingDTO;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.BuildingRepository;
import com.javaweb.repository.RentAreaRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.IBuildingService;
import com.javaweb.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional
public class BuildingService implements IBuildingService {

    @Autowired
    BuildingRepository buildingRepository;

    @Autowired
    RentAreaRepository rentAreaRepository;

    @Autowired
    BuildingConverter buildingConverter;

    @Autowired
    ModelMapper modelMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    UploadFileUtils uploadFileUtils;

    private static ResponseDTO getResponseDTO(BuildingEntity buildingEntity, List<UserEntity> staffs) {
        List<UserEntity> assignedStaffs = buildingEntity.getUsers();

        List<StaffResponseDTO> staffResponseDTOS = new ArrayList<>();
        for (UserEntity staff : staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setStaffId(staff.getId());
            staffResponseDTO.setFullName(staff.getFullName());

            boolean isAssigned = assignedStaffs.contains(staff);
            if (isAssigned) {
                staffResponseDTO.setChecked("checked");
            } else {
                staffResponseDTO.setChecked("");
            }

            staffResponseDTOS.add(staffResponseDTO);
        }

        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(staffResponseDTOS);
        responseDTO.setMessage("Success");
        return responseDTO;
    }

    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/repository/building/" + buildingDTO.getImageName();
        if (buildingDTO.getImageBase64() != null) {
            if (buildingEntity.getImage() != null) {
                if (!path.equals(buildingEntity.getImage())) {
                    File file = new File("C://home/office" + buildingEntity.getImage());
                    file.delete();
                }
            }

            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().split(",")[1]);
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setImage(path);
        }
    }

    @Override
    public List<BuildingSearchResponse> getBuildingSearchResponses(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        List<BuildingSearchResponse> buildingSearchResponses = new ArrayList<>();
        Page<BuildingEntity> buildings = buildingRepository.findBuildings(buildingSearchRequest, pageable);

        for (BuildingEntity building : buildings.getContent()) {
            BuildingSearchResponse dto = buildingConverter.BuildingResponseDTO(building);
            buildingSearchResponses.add(dto);
        }
        return buildingSearchResponses;
    }

    @Override
    public String createOrUpdateBuilding(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity;

        if (buildingDTO.getId() != null) {
            // Retrieve existing building entity if updating
            buildingEntity = buildingRepository.findById(buildingDTO.getId()).get();
        } else {
            // Create new building entity if adding
            buildingEntity = new BuildingEntity();
        }

        // Update building entity fields from DTO
        buildingConverter.DTOtoBuildingEntity(buildingDTO, buildingEntity);

        // Rent areas
        if (buildingDTO.getRentArea() != null && !buildingDTO.getRentArea().trim().isEmpty()) {
            // Split the rent area values from the DTO
            List<Long> newRentAreaValues = Arrays.stream(buildingDTO.getRentArea().trim().split("\\s*,\\s*"))
                    .map(String::trim)
                    .map(Long::valueOf)
                    .collect(Collectors.toList());

            List<RentAreaEntity> existingRentAreas = buildingEntity.getRentAreas();

            // Clear the existing rent areas if any
            if (existingRentAreas != null) {
                existingRentAreas.clear();
            } else {
                existingRentAreas = new ArrayList<>();
            }

            // Add the new rent areas
            for (Long newRentAreaValue : newRentAreaValues) {
                RentAreaEntity newRentArea = new RentAreaEntity();
                newRentArea.setValue(newRentAreaValue);
                newRentArea.setBuildingEntity(buildingEntity);
                existingRentAreas.add(newRentArea);
            }

            buildingEntity.setRentAreas(existingRentAreas);
        }

        try {
            if (buildingDTO.getImageName() != null && buildingDTO.getImageBase64() != null) {
                saveThumbnail(buildingDTO, buildingEntity);
            } else if (buildingDTO.getId() == null) {
                saveThumbnail(buildingDTO, buildingEntity);
            }

            buildingRepository.save(buildingEntity);

            return buildingDTO.getId() != null ? "Đã sửa building thành công!" : "Đã thêm building thành công!";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @Override
    public BuildingDTO editBuilding(Long id) {
        BuildingEntity buildingEntity = buildingRepository.findById(id).get();
        return buildingConverter.BuildingEntityToDTO(buildingEntity);
    }

    @Override
    public void deleteBuildings(List<Long> ids) {
        for (Long id : ids) {
            BuildingEntity buildingEntity = buildingRepository.findById(id).get();
            if (buildingEntity != null) {
                // Clear the users associated with the building
                buildingEntity.getUsers().clear();
            }
        }

        // One-liner chỉ được khi building đó chưa đc assign staff
        buildingRepository.deleteByIdIn(ids);
    }

    @Override
    public ResponseDTO getAllStaffs(Long buildingId) {
        BuildingEntity buildingEntity = buildingRepository.findById(buildingId).get();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        return getResponseDTO(buildingEntity, staffs);
    }

    @Override
    public String updateAssignmentBuilding(AssignmentBuildingDTO assignmentBuildingDTO) {
        try {
            BuildingEntity buildingEntity = buildingRepository.findById(assignmentBuildingDTO.getBuildingId()).get();

            if (buildingEntity != null) {
                buildingEntity.getUsers().clear();
                List<UserEntity> users = new ArrayList<>();

                if (!assignmentBuildingDTO.getStaffs().isEmpty()) {
                    for (Long id : assignmentBuildingDTO.getStaffs()) {
                        UserEntity userEntity = userRepository.findById(id).get();
                        if (userEntity != null) {
                            users.add(userEntity);
                        }
                    }
                    buildingEntity.setUsers(users);
                }

                buildingRepository.save(buildingEntity);
            }

        } catch (Exception e) {
            return e.getMessage();
        }

        return "Da them nhan vien thanh cong!";
    }

    @Override
    public Integer countTotalItems(BuildingSearchRequest buildingSearchRequest) {
        return buildingRepository.countTotalItems(buildingSearchRequest);
    }
}
