package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

// DỮ LIỆU ÍT BỊ THAY ĐỔI THÌ DÙNG ENUM THAY VÌ LÔI TỪ DB LÊN!!!!!!!!
public enum district {
    QUAN_1("Quận 1"),
    QUAN_2("Quận 2"),
    QUAN_3("Quận 3"),
    QUAN_4("Quận 4"),
    QUAN_10("Quận 10"),
    QUAN_11("Quận 11"),
    QUAN_TB("Quận Tân Bình");

    private final String districtName;

    district(String name) {
        this.districtName = name;
    }

    public static Map<String, String> districtCode() {
        // Lưu nó vào cái map để display lên view
        Map<String, String> code = new LinkedHashMap<>();
        //key là mấy cái QUAN_1 còn value là "Quận 1"
        for (district d : district.values()) {
            code.put(d.toString(), d.getDistrictName());
        }
        return code;
    }

    public static String getDistrictNameByCode(String code) {
        // The valueOf method is used to convert a string representation of an enum constant to the actual enum constant.
        try {
            return district.valueOf(code).getDistrictName();
        } catch (Exception e) {
            return null;
        }

    }

    private String getDistrictName() {
        return districtName;
    }
}
