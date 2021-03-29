<%--
  Created by IntelliJ IDEA.
  User: crazlee
  Date: 2021/3/28
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <%--引入jQuery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.5.1.js"></script>
    <%--引入样式--%>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--员工修改的模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_update_input"
                                   placeholder="email@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="W">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<%--员工添加的模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="empName" id="empName_add_input"
                                   placeholder="xxx">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">员工邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="email" id="email_add_input"
                                   placeholder="email@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="W">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名称</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--功能按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="addEmp_Btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--员工信息显示--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_All"/>
                    </th>
                    <th>员工ID</th>
                    <th>员工姓名</th>
                    <th>员工性别</th>
                    <th>员工邮箱</th>
                    <th>员工所在部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">
    //全局定义总页数，方便添加员工之后直接跳转到最后一页
    let lastPage;
    //定义当前页面，方便编辑之后跳转到编辑员工所在页面
    let currentPage;
    //1.页面加载完成以后，直接发送一个ajax请求，要到分页数据
    $(function () {
        //初始在第一页
        to_page(1);
    })

    //跳转页面
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析显示分页条数据
                build_page_nav(result);
            }
        })
    }

    //解析显示员工信息
    function build_emps_table(result) {
        //清空当前表格数据
        $("#emps_table tbody").empty();
        // console.log(result);
        let emps = result.extend.pageInfo.list;
        $.each(emps, function (index, emp) {
            let checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            let empIdTd = $("<td></td>").append(emp.empId);
            let empNameTd = $("<td></td>").append(emp.empName);
            let empGenderTd = $("<td></td>").append(emp.gender == 'M' ? "男" : "女");
            let empEmailTd = $("<td></td>").append(emp.email);

            let empDeptTd = $("<td></td>").append(emp.department.deptName);

            let editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")
                    .append("编辑"));

            //为编辑按钮添加一个自定义属性，表示当前员工的id，方便之后修改取值
            editBtn.attr("edit_id", emp.empId);

            let deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")
                    .append("删除"));

            //为单个员工删除按钮添加一个自定义属性，表示当前员工id，方便之后取值
            deleteBtn.attr("delete_id", emp.empId);

            let btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();

        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum
            + "页，一共" + result.extend.pageInfo.pages
            + "页，总共" + result.extend.pageInfo.total + "条记录")
        lastPage = result.extend.pageInfo.pages;
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();

        let ul = $("<ul></ul>").addClass("pagination")

        let firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        let prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断禁用标志
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //绑定跳转逻辑
            firstPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        let nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        let lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        //判断禁用标志
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //绑定跳转逻辑
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            })
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }
        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            let numLi = $("<li></li>").append($("<a></a>").append(item));
            //当前页码高亮显示
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);

        let navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //给新增按钮绑定单击事件
    $("#addEmp_Btn").click(function () {
        //删除前一次的样式
        reset_form("#empAddModal form");
        //删除前一次表单的数据
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: 'static'
        })
    })

    //重置表单
    function reset_form(ele) {
        //重置表单数据
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //查询部门信息
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();

        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                $.each(result.extend.depts, function () {
                    let optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    $(ele).append(optionEle)
                })
            }
        })
    }

    //给添加员工的保存按钮绑定单击事件
    $("#emp_save_btn").click(function () {
        //0.先对要提交给服务器的数据进行校验
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        if (!validate_add_form()) {
            return false;
        }
        //1.模态框中填写的表单数据提交给服务器进行保存
        //2.发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code == 666) {
                    //保存成功:
                    // 1.关闭模态框；
                    $("#empAddModal").modal('hide');
                    // 2.显示保存的数据
                    to_page(lastPage + 1);
                } else {
                    //显示失败信息
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示名字错误信息
                        show_validate_msg("empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        })
    })

    //校验表单数据
    function validate_add_form() {
        let empName = $("#empName_add_input").val();
        let regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            // alert("用户名必须为2-5位中文字符或6-16位英文和数字字符");
            show_validate_msg("#empName_add_input", "error", "用户名必须为2-5位中文字符或6-16位英文和数字字符")
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名必须为2-5位中文字符或6-16位英文和数字字符");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "用户名可用 √");
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("用户名可用 √");
        }
        let email = $("#email_add_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确！");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确！");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确!!!");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "邮箱格式正确 √")
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("邮箱格式正确 √");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清楚当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //给员工姓名输入框绑定change事件,提前校验用户名是否可用
    $("#empName_add_input").change(function () {
        let empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 666) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else if (result.code = 233333) {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        })
    })

    /*
    * 给员工修改按钮绑定单击事件，但是在创建按钮之间就绑定click的话是绑定不上的
    * 所有调用新版jQuery的on事件
    * */
    $(document).on("click", ".edit_btn", function () {
        //1.查询员工信息
        getEmp($(this).attr("edit_id"));
        //2.查询部门信息
        getDepts("#dept_update_select");
        //3.把员工的id传递给模态框的更新按钮，方便后续更新操作
        $("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
        //4.弹出模态框显示
        $("#empUpdateModal").modal({
            backdrop: 'static'
        })
    })

    //用于查询员工信息
    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                let empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        })
    }

    //给编辑员工中更新按钮绑定单击事件
    $("#emp_update_btn").click(function () {
        //1.验证更新后的邮箱是否合法
        let email = $("#email_update_input").val();
        let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "邮箱格式正确 √")
        }
        //2.发送ajax请求，更新员工信息
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit_id"),
            type: "PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.提示用户更新完成
                alert("员工信息已更新！");
                //3.回到本页面
                to_page(currentPage);
            }
        })
    })

    //给员工删除按钮绑定单击事件
    $(document).on("click", ".delete_btn", function () {
        //1.弹出是否确认删除的对话框
        let empName = $(this).parents("tr").find("td:eq(2)").text();
        let empId = $(this).attr("delete_id");
        if (confirm("确认删除【" + empName + "】吗?")) {
            //确认删除
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    //1.提示用户已经删除
                    alert("已经删除员工");
                    //2.返回到当前页
                    to_page(currentPage);
                }
            })
        }
    })

    //完成全选/全部选的功能
    $("#check_All").click(function () {
        /*
        * attr获取checked是undefined，attr获取的是自定义属性的值；
        * dom的原生属性使用prop修改和读取
        * */
        $(".check_item").prop("checked", $(this).prop("checked"));
    })

    //逐个点击完成全选
    $(document).on("click", ".check_item", function () {
        //判断当前选中个数是否等于页面所显示的个数
        let flag = ($(".check_item:checked").length == $(".check_item").length);
        $("#check_All").prop("checked", flag);
    })

    //功能按钮删除,批量删除——提示员工信息
    $("#emp_delete_all_btn").click(function () {
        //将员工信息拼接
        let empNames = "";
        //拼接员工id字符串
        let del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        //去除多余的，
        empNames = empNames.substring(0, empNames.length - 1);
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            //发送ajax请求删除
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })
</script>
</body>
</html>
