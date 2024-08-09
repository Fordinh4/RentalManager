<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <title>Thông tin tòa nhà</title>
</head>
<body style="font-family: Arial, Helvetica, sans-serif">
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check("breadcrumbs", "fixed");
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="/admin/building-list">Home Admin</a>
                </li>
                <li class="active">Thông Tin Tòa Nhà</li>
            </ul>
            <!-- /.breadcrumb -->
        </div>

        <div
                class="page-content"
                style="font-family: Arial, Helvetica, sans-serif"
        >
            <div class="page-header">
                <h1>
                    Thông Tin Tòa Nhà
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div>
            <!-- /.page-header -->

            <div class="row" style="font-family: Arial, Helvetica, sans-serif">
                <form:form modelAttribute="buildingEdit" id="form-edit">
                    <div class="col-xs-12">
                        <form class="form-horizontal">
                            <!-- Hidden input for id -->
                            <form:hidden path="id"/>
                            <div class="form-group">
                                <label class="col-xs-3">Tên tòa nhà</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="name"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Quận</label>
                                <div class="col-xs-3">
                                    <div>
                                        <form:select path="district" class="form-control">
                                            <form:option value="">--Chọn quận--</form:option>
                                            <form:options items="${districtCode}"></form:options>
                                        </form:select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phường</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="ward"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Đường</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="street"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Kết cấu</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="structure"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Số tầng hầm</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="numberOfBasement" type="number"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Diện tích sàn</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="floorArea" type="number"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Hướng</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="direction"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Hạng</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="level"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Diện tích thuê</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="rentArea"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Giá thuê</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="rentPrice" type="number"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Mô tả giá</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="rentPriceDescription"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí dịch vụ</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="serviceFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí ô tô</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="carFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí mô tô</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="motoFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí ngoài giờ</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="overtimeFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tiền điện</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="electricityFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tiền nước</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="waterFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Đặt cọc</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="deposit"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Thanh toán</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="payment"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Thời hạn thuê</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="rentTime"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Thời gian trang trí</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="decorationTime"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Tên quản lý</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="managerName"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">SĐT quản lý</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="managerPhone" type="number"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Loại tòa nhà</label>
                                <div class="col-xs-9">
                                    <div class="col-xs-4">
                                        <form:checkboxes path="typeCode" items="${typeCode}"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Phí môi giới</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="brokerageFee"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3">Ghi chú</label>
                                <div class="col-xs-9">
                                    <form:input class="form-control" path="note"/>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 no-padding-right">Hình đại diện</label>
                                <input class="col-sm-3 no-padding-right" type="file" id="uploadImage"/>
                                <div class="col-sm-9">
                                    <c:if test="${not empty buildingEdit.image}">
                                        <c:set var="imagePath" value="/repository${buildingEdit.image}"/>
                                        <img src="${imagePath}" id="viewImage" width="300px" height="300px"
                                             style="margin-top: 50px">
                                    </c:if>
                                    <c:if test="${empty buildingEdit.image}">
                                        <img src="/img/default.png" id="viewImage" width="300px" height="300px">
                                    </c:if>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-xs-3"></label>
                                <div class="col-xs-9">
                                    <c:if test="${empty buildingEdit.id}">
                                        <button
                                                type="button"
                                                class="btn btn-primary"
                                                id="btnAddBuilding"
                                        >
                                            Thêm tòa nhà
                                        </button>
                                    </c:if>
                                    <c:if test="${not empty buildingEdit.id}">
                                        <button
                                                type="button"
                                                class="btn btn-warning"
                                                id="btnAddBuilding"
                                        >
                                            Sửa tòa nhà
                                        </button>
                                    </c:if>
                                    <a href="/admin/building-list">
                                        <button class="btn btn-primary" type="button">
                                            Hủy thao tác
                                        </button>
                                    </a>
                                    <img src="/img/loading.gif" style="display: none; height: 100px" id="loading_image">
                                </div>
                            </div>
                        </form>
                    </div>

                </form:form>
            </div>
        </div>
    </div>
    <!-- /.page-content -->
</div>
<script>
    // gởi thì dùng Jquery
    // nhận bên DB thì dùng ajax
    var imageBase64 = '';
    var imageName = '';

    $("#btnAddBuilding").click(function () {
            // for each input field in the form, the formData will have an array like [{name:"..", value:"..."},...] as its value
            var json = {};
            var typeCode = [];
            var formData = $("#form-edit").serializeArray();
            $.each(formData, function (i, item) {
                if (item.name != 'typeCode') json["" + item.name + ""] = item.value;
                else typeCode.push(item.value);
            });

            if ('' !== imageBase64) {
                json['imageBase64'] = imageBase64;
                json['imageName'] = imageName;
            }

            json['typeCode'] = typeCode;
            if (json['name'] == "") {
                return alert("Ten toa nha bi thieu!");
            } else if (json['rentArea'] == "") {
                return alert("Dien tich thue bi thieu!");
            } else if (json['street'] == "") {
                return alert("Duong bi thieu!");
            } else if (json['district'] == "") {
                return alert("Quan bi thieu!");
            } else if (json['typeCode'] == "") {
                return alert("Loai toa nha bi thieu!");
            } else if (json['imageName'] != null && json['imageName'].indexOf(' ') >= 0) {
                return alert("Tên hình ảnh không được có space!");
            } else {
                addOrUpdateBuilding(json);
            }
        }
    )
    ;

    function addOrUpdateBuilding(data) {
        $('#loading_image').show();

        $.ajax({
            type: "POST",
            url: "/api/buildings",
            data: JSON.stringify(data),
            dataType: "text", // kiểu dữ liệu mà server trả ra cho client
            contentType: "application/json",
            success: function (response) {
                $('#loading_image').hide();
                alert(response);
                window.location.replace("/admin/building-list")
            },
            error: function (response) {
                $('#loading_image').hide();
                alert(response);
            },
        });
    }

    $('#uploadImage').change(function (event) {
        var reader = new FileReader();
        var file = $(this)[0].files[0];
        reader.onload = function (e) {
            imageBase64 = e.target.result;
            imageName = file.name; // ten hinh khong dau, khoang cach. vd: a-b-c
        };
        reader.readAsDataURL(file);
        openImage(this, "viewImage");
    });

    function openImage(input, imageView) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#' + imageView).attr('src', reader.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

</body>
</html>
