package com.javaweb.enums;

import java.util.LinkedHashMap;
import java.util.Map;

// DỮ LIỆU ÍT BỊ THAY ĐỔI THÌ DÙNG ENUM THAY VÌ LÔI TỪ DB LÊN!!!!!!!!
public enum rentType {
    TANG_TRET("Tầng trệt"),
    NGUYEN_CAN("Nguyên căn"),
    NOI_THAT("Nội thất");

    private final String name;

    rentType(String name) {
        this.name = name;
    }

    public static Map<String, String> typeCode() {
        // Lưu nó vào cái map để display lên view
        Map<String, String> code = new LinkedHashMap<>();
        for (rentType item : rentType.values()) {
            code.put(item.toString(), item.getName());
        }
        return code;
    }

    private String getName() {
        return name;
    }

}
