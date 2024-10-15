package Servlet;

import Bean.Credit;
import Bean.Status;
import Service.IStatusService;
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

@WebServlet("/Credit")
public class CreditServlet extends HttpServlet {
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method){
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
        Credit credit = MyBeanUtil.copyToBean(req, Credit.class);
        String sql = "INSERT INTO credit (borrow_card_num) VALUES(?)";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, credit.getBorrowCardNum());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "SELECT * FROM credit WHERE id = ?";
        Credit credit = MySQLUtil.SELECTone(sql, Credit.class, id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), credit);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Credit credit = MyBeanUtil.copyToBean(req, Credit.class);
        String sql = "UPDATE credit SET borrow_card_num = ? WHERE id = ?";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, credit.getBorrowCardNum(), credit.getId());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean isOk = false;
        for (String id : ids) {
            String sql = "DELETE FROM credit WHERE id = ?";
            isOk = MySQLUtil.UPDATE(sql, null, id);
        }
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "DELETE FROM credit WHERE id = ?";
        Boolean del = MySQLUtil.UPDATE(sql, null, id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String sql = "SELECT * FROM credit";
        List<Credit> credits = MySQLUtil.SELECT(sql, Credit.class, null);
        PageTable pageTable = new PageTable(0, "", credits.size(), credits);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }
}