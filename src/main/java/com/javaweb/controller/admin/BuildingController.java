package com.javaweb.controller.admin;

import com.javaweb.constant.SystemConstant;
import com.javaweb.enums.district;
import com.javaweb.enums.rentType;
import com.javaweb.model.dto.BuildingDTO;
import com.javaweb.model.request.BuildingSearchRequest;
import com.javaweb.model.response.BuildingSearchResponse;
import com.javaweb.service.IBuildingService;
import com.javaweb.service.IUserService;
import com.javaweb.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController(value = "buildingControllerOfAdmin")
public class BuildingController {
    @Autowired
    private IUserService userService;

    @Autowired
    private IBuildingService buildingService;

    @GetMapping(value = "/admin/building-list")
    public ModelAndView buildingList(@ModelAttribute(name = "modelSearch") BuildingSearchRequest model, HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("admin/building/list");
        DisplayTagUtils.of(request, model);
        List<BuildingSearchResponse> result = buildingService.getBuildingSearchResponses(model, PageRequest.of(model.getPage() - 1, model.getMaxPageItems()));
        model.setListResult(result);
        model.setTotalItem(buildingService.countTotalItems(model));

        modelAndView.addObject("districtCode", district.districtCode());
        modelAndView.addObject("staffs", userService.getStaffs());
        modelAndView.addObject("typeCode", rentType.typeCode());
        modelAndView.addObject(SystemConstant.MODEL, model);

        return modelAndView;
    }


    @GetMapping(value = "/admin/building-edit")
    public ModelAndView buildingEdit(@ModelAttribute(name = "buildingEdit") BuildingDTO buildingDTO) {
        ModelAndView modelAndView = new ModelAndView("admin/building/edit");
        modelAndView.addObject("districtCode", district.districtCode());
        modelAndView.addObject("typeCode", rentType.typeCode());

        return modelAndView;
    }

    @GetMapping("/admin/building-edit-{id}")
    public ModelAndView buildingEdit(@PathVariable Long id) {
        ModelAndView modelAndView = new ModelAndView("admin/building/edit");
        BuildingDTO buildingDTO = buildingService.editBuilding(id);

        modelAndView.addObject("buildingEdit", buildingDTO);
        modelAndView.addObject("districtCode", district.districtCode());
        modelAndView.addObject("typeCode", rentType.typeCode());

        return modelAndView;
    }
}
