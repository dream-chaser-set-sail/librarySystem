package Servlet;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.UserQuery;
import Service.IAdminService;
import Service.impl.AdminService;
import Util.DelImageUtil;
import Util.MyBeanUtil;
import Util.MySQLUtil;
import Util.PageTable;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {
    private IAdminService iAdminService = new AdminService();
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method){
            case "add":
                add(req,resp);
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
            case "isStop":
                isStop(req,resp);
                break;
            case "upImg":
                upImg(req,resp);
                break;
            case "upPass":
                upPass(req,resp);
                break;
        }
    }

    private void upPass(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String pass = req.getParameter("pass");
        String id = req.getParameter("id");
        String sql = "UPDATE admin SET `password` = ? WHERE id = ?";
        Boolean update = MySQLUtil.UPDATE(sql, null, pass, id);
        if (update == true){
            HttpSession session = req.getSession();
            Admin isLogin = (Admin) session.getAttribute("isLogin");
            isLogin.setPassword(pass);
            session.setAttribute("isLogin", isLogin);
        }
        mapper.writeValue(resp.getWriter(), update);
    }

    private void upImg(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String imgName = req.getParameter("imgName");
        String id = req.getParameter("id");
        Integer role = Integer.valueOf(req.getParameter("role"));
        Boolean result = false;
        String sql1 = "SELECT image FROM admin WHERE admin_card_num = ?";
        Admin admin = MySQLUtil.SELECTone(sql1, Admin.class, id);
        Boolean isOk = DelImageUtil.DelImg(admin.getImage());
        if (isOk == true){
            String sql2 = "UPDATE admin SET `image` = ? WHERE admin_card_num = ?";
            String sql3 = "UPDATE borrow_cards SET `image` = ? WHERE borrow_card_num = ?";
            Boolean update = MySQLUtil.UPDATE(sql2, null, imgName, id);
            Boolean update2 = MySQLUtil.UPDATE(sql3, null, imgName, id);
            if (update == true || update2 == true){
                result = true;
                HttpSession session = req.getSession();
                if (role == 0) {
                    Admin isLogin = (Admin) session.getAttribute("isLogin");
                    isLogin.setImage(imgName);
                    session.setAttribute("isLogin", isLogin);
                }else if (role == 1){
                    BorrowCard isLogin = (BorrowCard) session.getAttribute("isLogin");
                    isLogin.setImage(imgName);
                    session.setAttribute("isLogin", isLogin);
                }
            }
        }
        mapper.writeValue(resp.getWriter(), result);
    }

    private void isStop(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String isStop = req.getParameter("isStop");
        Integer id = Integer.valueOf(req.getParameter("id"));
        Boolean stop = iAdminService.isStop(id, isStop);
        mapper.writeValue(resp.getWriter(), stop);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean delAll = iAdminService.delAll(ids);
        mapper.writeValue(resp.getWriter(), delAll);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Boolean del = iAdminService.del(id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserQuery userQuery = MyBeanUtil.copyToBean(req, UserQuery.class);
        PageTable pageTable = iAdminService.selPage(userQuery);
        System.out.println(pageTable);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }

    private void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Admin admin = iAdminService.selAll(id);
        Boolean isadd = false;
        if (admin == null){
            isadd = iAdminService.add(id);
        }
        mapper.writeValue(resp.getWriter(), isadd);
    }
}
