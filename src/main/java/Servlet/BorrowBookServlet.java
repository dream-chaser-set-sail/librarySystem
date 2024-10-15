package Servlet;

import Bean.Books;
import Bean.UserQuery;
import Service.IBorrowBookService;
import Service.impl.BorrowBookService;
import Util.MyBeanUtil;
import Util.PageTable;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/BorrowBook")
public class BorrowBookServlet extends HttpServlet {
    private IBorrowBookService iBorrowBookService = new BorrowBookService();
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
            case "borrowBookNum":
                borrowBookNum(req,resp);
                break;
            case "selBook":
                selBook(req,resp);
                break;
            case "returnBook":
                returnBook(req,resp);
                break;
            case "renewal":
                renewal(req,resp);
                break;
            case "add":
                add(req,resp);
                break;
        }
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String isbn = req.getParameter("isbn");
        String uid = req.getParameter("uid");
        Integer addNum = Integer.valueOf(req.getParameter("addNum"));
        Map<String, Object> add = iBorrowBookService.add(uid, isbn, addNum);
        mapper.writeValue(resp.getWriter(), add);
    }

    private void renewal(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("BorrowBookServlet.renewal");
        Integer addNum = Integer.valueOf(req.getParameter("add"));
        String isbn = req.getParameter("isbn");
        String borrowCardNum = req.getParameter("borrowCardNum");
        Boolean isOK = iBorrowBookService.renewal(addNum, isbn, borrowCardNum);
        mapper.writeValue(resp.getWriter(), isOK);
    }

    private void returnBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String bid = req.getParameter("bid");
        String uid = req.getParameter("uid");
        Boolean isOK = iBorrowBookService.returnBook(bid, uid);
        mapper.writeValue(resp.getWriter(), isOK);
    }

    private void selBook(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        List<Books> books = iBorrowBookService.selBook(id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), books);
    }

    private void borrowBookNum(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Integer num = iBorrowBookService.borrowBookNum(id);
        mapper.writeValue(resp.getWriter(), num);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean delAll = iBorrowBookService.delAll(ids);
        mapper.writeValue(resp.getWriter(), delAll);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Boolean del = iBorrowBookService.del(id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserQuery userQuery = MyBeanUtil.copyToBean(req, UserQuery.class);
        PageTable pageTable = iBorrowBookService.selPage(userQuery);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }
}
