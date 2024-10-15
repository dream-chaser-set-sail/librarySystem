package Servlet;

import Bean.Admin;
import Bean.Books;
import Bean.BorrowCard;
import Bean.UserQuery;
import Service.IAdminService;
import Service.IBookService;
import Service.IBorrowCardService;
import Service.impl.AdminService;
import Service.impl.BookService;
import Service.impl.BorrowCardService;
import Util.MyBeanUtil;
import Util.PageTable;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/Book")
public class BookServlet extends HttpServlet {
    private IBookService iBookService = new BookService();
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
            case "selOwn":
                selOwn(req,resp);
                break;
            case "update":
                update(req,resp);
                break;
            case "add":
                add(req,resp);
                break;
            case "isTop":
                isTop(req,resp);
                break;
            case "borrowBook":
                borrowBook(req,resp);
                break;
            case "selBookByisbn":
                selBookByisbn(req,resp);
                break;
            case "selTop":
                selTop(req,resp);
                break;
            case "selClick":
                selClick(req,resp);
                break;
        }
    }

    private void selClick(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Books> clickBooks = iBookService.selClick();
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), clickBooks);
    }

    private void selTop(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Books> topBooks = iBookService.selTop();
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), topBooks);
    }

    private void selBookByisbn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String isbn = req.getParameter("isbn");
        Books books = iBookService.selBookByisbn(id, isbn);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), books);
    }

    private void borrowBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        List<Books> books = iBookService.borrowBook(id);
        HttpSession session = req.getSession();
        session.setAttribute("books", books);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), books);
    }

    private void isTop(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String isTop = req.getParameter("isTop");
        Integer id = Integer.valueOf(req.getParameter("id"));
        Boolean top = iBookService.isTop(id, isTop);
        mapper.writeValue(resp.getWriter(), top);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Books books = MyBeanUtil.copyToBean(req, Books.class);
        Boolean isAdd = iBookService.add(books);
        mapper.writeValue(resp.getWriter(), isAdd);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Books books = MyBeanUtil.copyToBean(req, Books.class);
        Boolean update = iBookService.update(books);
        mapper.writeValue(resp.getWriter(), update);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Books books = iBookService.selOwn(id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), books);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean delAll = iBookService.delAll(ids);
        mapper.writeValue(resp.getWriter(), delAll);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Boolean del = iBookService.del(id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserQuery userQuery = MyBeanUtil.copyToBean(req, UserQuery.class);
        PageTable pageTable = iBookService.selPage(userQuery);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }
}
