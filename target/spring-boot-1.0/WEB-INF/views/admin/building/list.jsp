<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="buildingAPI" value="/api/buildings/"/>
<html>
<head>
    <title>Danh sách tòa nhà</title>
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
                <li class="active">Danh Sách Tòa Nhà</li>
            </ul>
            <!-- /.breadcrumb -->
        </div>

        <div class="page-content">
            <div class="page-header">
                <h1>
                    Danh Sách Tòa Nhà
                    <small>
                        <i class="ace-icon fa fa-angle-double-right"></i>
                        overview &amp; stats
                    </small>
                </h1>
            </div>
            <!-- /.page-header -->

            <div class="row" style="font-family: Arial, Helvetica, sans-serif">
                <div class="col-xs-12">
                    <div class="widget-box">
                        <div class="widget-header">
                            <h4 class="widget-title">Tìm kiếm</h4>

                            <span class="widget-toolbar">
                      <a href="#" data-action="reload">
                        <i class="ace-icon fa fa-refresh"></i>
                      </a>

                      <a href="#" data-action="collapse">
                        <i class="ace-icon fa fa-chevron-up"></i>
                      </a>

                      <a href="#" data-action="close">
                        <i class="ace-icon fa fa-times"></i>
                      </a>
                    </span>
                        </div>

                        <div class="widget-body">

                            <div class="widget-main">
                                <%--Phải thêm modelAtribute vào để form nó biết nó hứng data cho mình--%>
                                <form:form modelAttribute="modelSearch" action="/admin/building-list" id="listForm"
                                           method="GET">
                                <div class="row" style="font-family: Arial, Helvetica, sans-serif">
                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-6">
                                                <div>
                                                    <label>Tên tòa nhà</label>
                                                    <form:input class="form-control" path="name"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-6">
                                                <div>
                                                    <label>Diện tích sàn</label>
                                                    <form:input class="form-control" path="floorArea" type="number"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-2">
                                                <div>
                                                    <label>Chọn quận</label>
                                                        <%--Do có path là district r nên nó như mấy tag input trên--%>
                                                    <form:select path="district" class="form-control">
                                                        <form:option value="">--Chọn quận--</form:option>
                                                        <form:options items="${districtCode}"></form:options>
                                                    </form:select>
                                                </div>
                                            </div>

                                            <div class="col-xs-5">
                                                <div>
                                                    <label>Phường</label>
                                                    <form:input class="form-control" path="ward"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-5">
                                                <div>
                                                    <label>Đường</label>
                                                    <form:input class="form-control" path="street"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-4">
                                                <div>
                                                    <label>Số tầng hầm</label>
                                                    <form:input class="form-control" path="numberOfBasement"
                                                                type="number"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div>
                                                    <label>Hướng</label>
                                                    <form:input class="form-control" path="direction"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div>
                                                    <label>Hạng</label>
                                                    <form:input class="form-control" path="level" type="number"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-3">
                                                <div>
                                                    <label>Diện tích từ</label>
                                                    <form:input class="form-control" path="rentAreaFrom" type="number"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-3">
                                                <div>
                                                    <label>Diện tích đến</label>
                                                    <form:input class="form-control" path="rentAreaTo" type="number"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-3">
                                                <div>
                                                    <label>Giá thuê từ</label>
                                                    <form:input class="form-control" path="rentPriceFrom"
                                                                type="number"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-3">
                                                <div>
                                                    <label>Giá thuê đến</label>
                                                    <form:input class="form-control" path="rentPriceTo" type="number"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-5">
                                                <div>
                                                    <label>Tên quản lý</label>
                                                    <form:input class="form-control" path="managerName"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-5">
                                                <div>
                                                    <label>SĐT quản lý</label>
                                                    <form:input class="form-control" path="managerPhone" type="number"/>
                                                </div>
                                            </div>

                                            <div class="col-xs-2">
                                                <div>
                                                    <label>Chọn nhân viên</label>
                                                    <form:select path="staffId" class="form-control">
                                                        <form:option value="">--Chọn nhân viên--</form:option>
                                                        <form:options items="${staffs}"></form:options>
                                                    </form:select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-4">
                                                <form:checkboxes path="typeCode" items="${typeCode}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-xs-12">
                                            <div class="col-xs-2">
                                                <button class="btn btn-info" id="btnSearch">
                                                    <i
                                                            class="ace-icon glyphicon glyphicon-search"
                                                    ></i>
                                                    Tìm kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </form:form>
                        </div>
                        <div class="pull-right">
                            <a href="/admin/building-edit">
                                <button
                                        class="btn btn-app btn-success btn-xs"
                                        title="Thêm tòa nhà"
                                >
                                    <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            width="16"
                                            height="16"
                                            fill="currentColor"
                                            class="bi bi-building-fill-add"
                                            viewBox="0 0 16 16"
                                    >
                                        <path
                                                d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"
                                        />
                                        <path
                                                d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v7.256A4.5 4.5 0 0 0 12.5 8a4.5 4.5 0 0 0-3.59 1.787A.5.5 0 0 0 9 9.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .39-.187A4.5 4.5 0 0 0 8.027 12H6.5a.5.5 0 0 0-.5.5V16H3a1 1 0 0 1-1-1zm2 1.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3 0v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"
                                        />
                                    </svg>
                                </button>
                            </a>
                            <button
                                    class="btn btn-app btn-danger btn-xs"
                                    title="Xóa tòa nhà"
                                    id="btnDeleteBuilding"
                            >
                                <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        width="16"
                                        height="16"
                                        fill="currentColor"
                                        class="bi bi-building-fill-dash"
                                        viewBox="0 0 16 16"
                                >
                                    <path
                                            d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1"
                                    />
                                    <path
                                            d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v7.256A4.5 4.5 0 0 0 12.5 8a4.5 4.5 0 0 0-3.59 1.787A.5.5 0 0 0 9 9.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .39-.187A4.5 4.5 0 0 0 8.027 12H6.5a.5.5 0 0 0-.5.5V16H3a1 1 0 0 1-1-1zm2 1.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3 0v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5m3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5M4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"
                                    />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hr hr-30 dotted hr-double"></div>
            <!-- table -->
            <div class="row" style="font-family: Arial, Helvetica, sans-serif">
                <div class="col-xs-12">
                    <div class="table-responsive">
                        <display:table name="model.listResult" id="tableList" requestURI="/admin/building-list"
                                       pagesize="${model.maxPageItems}" cellpadding="0" cellspacing="0"
                                       partialList="true" sort="external" defaultsort="2"
                                       size="${model.totalItem}" defaultorder="ascending"
                                       class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                       export="false">
                            <display:column
                                    title="<fieldset class='form-group'><input type='checkbox' id='checkAll' class='check-box-element'></fieldset>"
                                    class="center select-cell" headerClass="center select-cell">
                                <fieldset>
                                    <input type="checkbox" name="checkList" value="${tableList.id}"
                                           id="checkbox_${tableList.id}"
                                           class="check-box-element"/>
                                </fieldset>
                            </display:column>
                            <display:column property="name" title="Tên tòa nhà" headerClass="text-left"/>
                            <display:column property="address" title="Địa chỉ" headerClass="text-left"/>
                            <display:column property="numberOfBasement" title="Số tầng hầm" headerClass="text-left"/>
                            <display:column property="managerName" title="Tên quản lý" headerClass="text-left"/>
                            <display:column property="managerPhone" title="Số điện thoại quản lý"
                                            headerClass="text-left"/>
                            <display:column property="floorArea" title="D.tích sàn" headerClass="text-left"/>
                            <display:column property="emptyArea" title="D.tích trống" headerClass="text-left"/>
                            <display:column property="rentPrice" title="Giá thuê" headerClass="text-left"/>
                            <display:column property="serviceFee" title="Phí dịch vụ" headerClass="text-left"/>
                            <display:column property="brokerageFee" title="Phí MG" headerClass="text-left"/>
                            <display:column title="Thao tác" headerClass="col-actions">
                                <div class="hidden-sm hidden-xs btn-group">
                                    <button class="btn btn-xs btn-success" title="Giao tòa nhà"
                                            onclick="assignmentBuilding(${tableList.id})">
                                        <i class="ace-icon fa fa-list"></i>
                                    </button>

                                    <a href="/admin/building-edit-${tableList.id}">
                                        <button class="btn btn-xs btn-info" title="Sửa thông tin">
                                            <i class="ace-icon fa fa-pencil bigger-120"></i>
                                        </button>
                                    </a>

                                    <button class="btn btn-xs btn-danger" title="Xóa tòa nhà"
                                            onclick="deleteBuilding(${tableList.id})">
                                        <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                    </button>
                                </div>
                            </display:column>
                        </display:table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /.page-content -->
</div>
<!-- Modal -->
<div id="assignmentBuildingModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>
            <div class="modal-body">
                <table
                        id="staffList"
                        class="table table-striped table-bordered table-hover"
                >
                    <thead>
                    <tr>
                        <th class="center">
                            <label class="pos-rel">
                                <input type="checkbox" class="ace" value="1"/>
                                <span class="lbl"></span>
                            </label>
                        </th>
                        <th class="center">Tên nhân viên</th>
                    </tr>
                    </thead>

                    <tbody>
                    <%--                    <tr>--%>
                    <%--                        <td class="center">--%>
                    <%--                            <label class="pos-rel">--%>
                    <%--                                <input type="checkbox" class="ace" value="1"/>--%>
                    <%--                                <span class="lbl"></span>--%>
                    <%--                            </label>--%>
                    <%--                        </td>--%>

                    <%--                        <td class="center">Nguyễn Văn A</td>--%>
                    <%--                    </tr>--%>
                    </tbody>
                </table>
                <input type="hidden" name="buildingId" id="buildingId" value=""/>
            </div>
            <div class="modal-footer">
                <button
                        type="button"
                        class="btn btn-primary"
                        id="btnAssignmentBuilding"
                >
                    Giao tòa nhà
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    Đóng
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Assign buildings to employee
    function assignmentBuilding(buildingId) {
        // Id from html selector
        $("#assignmentBuildingModal").modal();
        $("#buildingId").val(buildingId);

        loadStaffs(buildingId);
    }

    // Staff related
    function loadStaffs(buildingId) {
        $.ajax({
            type: "GET",
            url: "${buildingAPI}" + buildingId + "/staffs",
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
                var row = '';
                $.each(response.data, function (index, item) {
                    row += '<tr>';
                    row += '<td class="center"> <input type="checkbox" class="check-box-element" value=' + item.staffId + ' id=checkbox_' + item.staffId + ' ' + item.checked + '/></td>';
                    row += '<td class = "center">' + item.fullName + '</td>';
                    row += '</tr>';
                });
                $('#staffList tbody').html(row);
                console.log("success");

            },
            error: function () {
                alert("Failed!");
            },
        });
    }

    $("#btnAssignmentBuilding").click(function (e) {
        e.preventDefault(); // to prevent from submitting
        var data = {};
        data["buildingId"] = $("#buildingId").val();
        var staffs = $("#staffList")
            .find("tbody input[type=checkbox]:checked")
            .map(function () {
                return $(this).val();
            })
            .get();
        data["staffs"] = staffs;
        assignBuilding(data);
    });

    function assignBuilding(data) {
        $.ajax({
            type: "POST",
            url: "${buildingAPI}staffs",
            data: JSON.stringify(data),
            dataType: "text", // kiểu dữ liệu mà server trả ra cho client
            contentType: "application/json",
            success: function (response) {
                alert(response);
                window.location.replace("/admin/building-list");
            },
            error: function (response) {
                alert(response);
            },
        });
    }

    // Delete building(s)
    function deleteBuilding(buildingId) {
        var data = {};
        data["buildingId"] = buildingId;
        deleteBuildings(data);
    }

    $("#btnDeleteBuilding").click(function (e) {
        e.preventDefault(); // to prevent from submitting
        var data = {};
        var buildingIds = $("input[name='checkList']:checked")
            .map(function () {
                return $(this).val();
            })
            .get();

        if (buildingIds.length === 0) {
            alert("Chọn ít nhất 1 tòa nhà để xóa!");
            return;
        }

        data["buildingIds"] = buildingIds;
        deleteBuildings(data);
    });

    function deleteBuildings(data) {
        let buildingTemp;
        if ('buildingIds' in data) {
            buildingTemp = data['buildingIds'];
        } else if ('buildingId' in data) {
            buildingTemp = data['buildingId'];
        }

        $.ajax({
            type: "DELETE",
            url: "${buildingAPI}" + buildingTemp,
            contentType: "application/json",
            success: function () {
                alert("Delete Success!");
                window.location.replace("/admin/building-list");
            },
            error: function () {
                alert("Delete Failed!");
            },
        });
    }

    $('#btnSearch').click(function (e) {
        e.preventDefault();
        $('#listForm').submit();

    });


</script>


</body>
</html>
