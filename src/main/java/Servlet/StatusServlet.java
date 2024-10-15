package Servlet;

import Bean.Role;
import Bean.Status;
import Service.IRoleService;
import Service.IStatusService;
import Service.impl.RoleService;
import Service.impl.StatusService;
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

@WebServlet("/Status")
public class StatusServlet extends HttpServlet {
    private IStatusService iStatusService = new StatusService();
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
        Status status = MyBeanUtil.copyToBean(req, Status.class);
        String sql = "INSERT INTO status (name) VALUES(?)";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, status.getName());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "SELECT * FROM status WHERE id = ?";
        Status status = MySQLUtil.SELECTone(sql, Status.class, id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), status);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Status status = MyBeanUtil.copyToBean(req, Status.class);
        String sql = "UPDATE status SET name = ? WHERE id = ?";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, status.getName(), status.getId());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean isOk = false;
        for (String id : ids) {
            String sql = "DELETE FROM status WHERE id = ?";
            isOk = MySQLUtil.UPDATE(sql, null, id);
        }
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "DELETE FROM status WHERE id = ?";
        Boolean del = MySQLUtil.UPDATE(sql, null, id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Status> statuses = iStatusService.selAll();
        PageTable pageTable = new PageTable(0, "", statuses.size(), statuses);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }

    private void selAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Status> statuses = iStatusService.selAll();
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), statuses);
    }
}
