package Servlet;

import Bean.BookClassifys;
import Bean.Books;
import Bean.Role;
import Service.IBookClassifyService;
import Service.IRoleService;
import Service.impl.BookClassifyService;
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

@WebServlet("/BookClassify")
public class BookClassifyServlet extends HttpServlet {
    private ObjectMapper mapper = new ObjectMapper();
    private IBookClassifyService iBookClassifyService = new BookClassifyService();
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
        BookClassifys bookClassifys = MyBeanUtil.copyToBean(req, BookClassifys.class);
        String sql = "INSERT INTO book_classify (name) VALUES(?)";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, bookClassifys.getName());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "SELECT * FROM book_classify WHERE id = ?";
        BookClassifys bookClassifys = MySQLUtil.SELECTone(sql, BookClassifys.class, id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), bookClassifys);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BookClassifys bookClassifys = MyBeanUtil.copyToBean(req, BookClassifys.class);
        String sql = "UPDATE book_classify SET name = ? WHERE id = ?";
        Boolean isOk = MySQLUtil.UPDATE(sql, null, bookClassifys.getName(), bookClassifys.getId());
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean isOk = false;
        for (String id : ids) {
            String sql = "DELETE FROM book_classify WHERE id = ?";
            isOk = MySQLUtil.UPDATE(sql, null, id);
        }
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String sql = "DELETE FROM book_classify WHERE id = ?";
        Boolean del = MySQLUtil.UPDATE(sql, null, id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<BookClassifys> bookClassifys = iBookClassifyService.selAll();
        PageTable pageTable = new PageTable(0, "", bookClassifys.size(), bookClassifys);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }

    private void    selAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<BookClassifys> bookClassifys = iBookClassifyService.selAll();
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), bookClassifys);
    }
}
