package Servlet;

import Bean.Department;
import Service.IDepartmentService;
import Service.impl.DepartmentService;
import Util.MyBeanUtil;
import Util.MySQLUtil;
import Util.PageTable;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/Department")
public class DepartmentServlet extends HttpServlet {
    private IDepartmentService iDepartmentService = new DepartmentService();
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method){
            case "selAll":
                selAll(req,resp);
                break;
            case "selPage":
                selPage(req,resp);
                break;
            case "del":
                del(req,resp);
                break;
            case "delAll":
                delAll(req,resp);
                break;
            case "update":
                update(req,resp);
                break;
            case "selOwn":
                selOwn(req,resp);
                break;
            case "add":
                add(req,resp);
                break;
        }
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Department department = MyBeanUtil.copyToBean(req, Department.class);
        String sql = "INSERT INTO department (name) VALUES(?)";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, department.getName());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "SELECT * FROM department WHERE id = ?";
        Department department = MySQLUtil.SELECTone(sql, Department.class, id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), department);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Department department = MyBeanUtil.copyToBean(req, Department.class);
        String sql = "UPDATE department SET name = ? WHERE id = ?";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, department.getName(), department.getId());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean isOk = false;
        for (String id : ids) {
            String sql = "DELETE FROM department WHERE id = ?";
            isOk = MySQLUtil.UPDATE(sql, null, id);
        }
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "DELETE FROM department WHERE id = ?";
        Boolean del = MySQLUtil.UPDATE(sql, null, id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Department> departments = iDepartmentService.selAll();
        PageTable pageTable = new PageTable(0, "", departments.size(), departments);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }

    private void selAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Department> departments = iDepartmentService.selAll();
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), departments);
    }
}
