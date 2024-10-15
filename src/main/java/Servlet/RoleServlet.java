package Servlet;

import Bean.Department;
import Bean.Role;
import Service.IRoleService;
import Service.impl.RoleService;
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

@WebServlet("/Role")
public class RoleServlet extends HttpServlet {
    private ObjectMapper mapper = new ObjectMapper();
    private IRoleService iRoleService = new RoleService();
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
        Role role = MyBeanUtil.copyToBean(req, Role.class);
        String sql = "INSERT INTO roles (name) VALUES(?)";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, role.getName());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "SELECT * FROM roles WHERE id = ?";
        Role role = MySQLUtil.SELECTone(sql, Role.class, id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), role);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Role role = MyBeanUtil.copyToBean(req, Role.class);
        String sql = "UPDATE roles SET name = ? WHERE id = ?";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, role.getName(), role.getId());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean isOk = false;
        for (String id : ids) {
            String sql = "DELETE FROM roles WHERE id = ?";
            isOk = MySQLUtil.UPDATE(sql, null, id);
        }
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "DELETE FROM roles WHERE id = ?";
        Boolean del = MySQLUtil.UPDATE(sql, null, id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Role> roles = iRoleService.selAll();
        PageTable pageTable = new PageTable(0, "", roles.size(), roles);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }

    private void selAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("RoleServlet.selAll");
        List<Role> roles = iRoleService.selAll();
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), roles);
    }
}
