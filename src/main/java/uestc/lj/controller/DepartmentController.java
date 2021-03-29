package uestc.lj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import uestc.lj.bean.Department;
import uestc.lj.bean.Msg;
import uestc.lj.service.DepartmentService;

import java.util.List;

/**
 * 处理和部门有关的请求
 *
 * @author crazlee
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     *
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        List<Department> departmentList = departmentService.getDepts();
        return Msg.success().add("depts", departmentList);
    }
}
