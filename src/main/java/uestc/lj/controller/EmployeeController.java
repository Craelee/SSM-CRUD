package uestc.lj.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import uestc.lj.bean.Employee;
import uestc.lj.bean.Msg;
import uestc.lj.service.EmployeeService;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 *
 * @author crazlee
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * 查询员工数据（分页查询）
     * 适用于客户端是网页
     *
     * @return
     */
    // @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//        //引入pageHelper插件
////        在查询之前调用，传入页码以及每页的大小
//        PageHelper.startPage(pn, 5);
//        List<Employee> employees = employeeService.getAll();
//        //使用pageinfo包装查询后的结果，只需要将pageinfo叫个页面就可
//        //传入连续显示的页数
//        PageInfo pageInfo = new PageInfo(employees, 5);
//        model.addAttribute("pageInfo", pageInfo);
//        return "list";
    //}

    /**
     * 查询所有员工的方法
     * 直接返回json
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(employees, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 保存员工信息
     * 前后端校验
     *
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        //后端校验
        if (result.hasErrors()) {
            //校验失败，返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.failed().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     *
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName) {
        //先进行用户名合法判断检查
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(regx)) {
            return Msg.failed().add("va_msg", "用户名必须为2-5位中文字符或6-16位英文和数字字符");
        }
        //再判断是否重名检测
        boolean isExit = employeeService.checkUser(empName);
        if (isExit) {
            return Msg.success();
        } else {
            return Msg.failed().add("va_msg", "用户名已被其他用户占用");
        }
    }

    /**
     * 查询单个员工信息
     *
     * @return
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * 更改员工信息
     * 直接发送PUT请求，配置HttpPutFormContentFilter
     *
     * @return
     */
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据员工id删除员工
     * 删除单个和批量删除
     *
     * @return
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        //批量删除
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteEmpByBatch(del_ids);
        } else {
            //单个删除
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}
