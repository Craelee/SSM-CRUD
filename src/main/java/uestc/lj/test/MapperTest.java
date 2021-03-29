package uestc.lj.test;


import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import uestc.lj.bean.Department;
import uestc.lj.bean.Employee;
import uestc.lj.dao.DepartmentMapper;
import uestc.lj.dao.EmployeeMapper;

import java.rmi.server.UID;
import java.util.UUID;

/**
 * 测试dao层的工作
 * 使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入Spring-test模块
 * 2.使用@ContextConfiguration指定Spring配置文件的位置
 *
 * @author crazlee
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void test1() {
/*        //1.创建springIoc容器
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2.从容其中获取mapper
        Department department = applicationContext.getBean(Department.class);*/
//        System.out.println(departmentMapper);
        //1.插入部门信息
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));

        //2.插入员工信息
//        employeeMapper.insertSelective(new Employee(null, "peter", "M", "peter@163.com", 1));

        //3.批量插入员工信息——使用批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 15; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "M", uid + "@163.com", 1));
        }
        for (int i = 15; i < 30; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "W", uid + "@126.com", 2));
        }
    }
}
