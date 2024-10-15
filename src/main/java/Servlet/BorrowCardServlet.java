package Servlet;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.UserQuery;
import Dao.IBorrowCardDao;
import Service.IAdminService;
import Service.IBorrowCardService;
import Service.impl.AdminService;
import Service.impl.BorrowCardService;
import Util.MyBeanUtil;
import Util.MySQLUtil;
import Util.PageTable;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.beanutils.BeanUtils;

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

@WebServlet("/BorrowCard")
public class BorrowCardServlet extends HttpServlet {
    private IBorrowCardService iBorrowCardService = new BorrowCardService();
    private ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        switch (method){
            case "register":
                register(req,resp);
                break;
            case "login":
                login(req,resp);
                break;
            case "selAdminCardNum":
                selAdminCardNum(req,resp);
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
            case "selOwn":
                selOwn(req,resp);
                break;
            case "update":
                update(req,resp);
                break;
            case "selUser":
                selUser(req,resp);
                break;
            case "quit":
                quit(req,resp);
                break;
            case "upByself":
                upByself(req,resp);
                break;
        }
    }

    private void upByself(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BorrowCard borrowCard = MyBeanUtil.copyToBean(req, BorrowCard.class);
        Boolean isOk = iBorrowCardService.upByself(borrowCard);
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void quit(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.invalidate();
        resp.sendRedirect("/page/login");
    }

    private void selUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        BorrowCard borrowCard = iBorrowCardService.selUser(id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), borrowCard);
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BorrowCard borrowCard = MyBeanUtil.copyToBean(req, BorrowCard.class);
        Boolean update = iBorrowCardService.update(borrowCard);
        mapper.writeValue(resp.getWriter(), update);
    }

    private void selOwn(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        BorrowCard borrowCard = iBorrowCardService.selOwn(id);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), borrowCard);
    }

    private void delAll(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String[] ids = req.getParameterValues("ids[]");
        Boolean delAll = iBorrowCardService.delAll(ids);
        mapper.writeValue(resp.getWriter(), delAll);
    }

    private void del(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        Boolean del = iBorrowCardService.del(id);
        mapper.writeValue(resp.getWriter(), del);
    }

    private void selPage(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserQuery userQuery = MyBeanUtil.copyToBean(req, UserQuery.class);
        PageTable pageTable = iBorrowCardService.selPage(userQuery);
        System.out.println(pageTable);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), pageTable);
    }

    private void selAdminCardNum(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String cardNum = req.getParameter("cardNum");
        Boolean isOk = iBorrowCardService.selAdminCardNum(cardNum);
        mapper.writeValue(resp.getWriter(), isOk);
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Admin admins = MyBeanUtil.copyToBean(req, Admin.class);
        String verificationCode = req.getParameter("verificationCode");
        Map<String, Object> map = new HashMap<>();
        Boolean isAdmin = false;
        Boolean isOk = false;
        String msg = "验证码有误，请重试";



        HttpSession session = req.getSession();
        // 验证码图片
        String codeInSession = (String) session.getAttribute("codeInSession");

        if (verificationCode.equals(codeInSession)){
            if (!"".equalsIgnoreCase(admins.getPassword()) && admins.getPassword() != null){
                // 管理员
                IAdminService iAdminService = new AdminService();
                Admin admin = iAdminService.loginAdmin(admins);
                if (admin != null){
                    // 密码正确，登录成功
                    session.setAttribute("isLogin", admin);
                    isOk = true;
                    isAdmin = true;
                    msg = "登录成功";
                }else {
                    msg = "用户名或密码有误，请重试";
                }

            }else {
                // 普通用户
                BorrowCard borrowCard = iBorrowCardService.loginBorrowCard(admins);
                if (borrowCard != null){
                    // 密码正确，登录成功
                    session.setAttribute("isLogin", borrowCard);
                    isOk = true;
                    msg = "登录成功";
                }else {
                    msg = "用户名或卡号有误，请重试";
                }

            }
        }

        map.put("isOk", isOk);
        map.put("admin", isAdmin);
        map.put("msg", msg);
        resp.setContentType("text/html;charset=UTF-8");
        mapper.writeValue(resp.getWriter(), map);
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        BorrowCard borrowCard = MyBeanUtil.copyToBean(req, BorrowCard.class);
        String code = req.getParameter("verificationCode");
        Boolean isOk = false;

        HttpSession session = req.getSession();
        // 验证码图片
        String codeInSession = (String) session.getAttribute("codeInSession");

        if(borrowCard != null){
            if(code.equalsIgnoreCase(codeInSession)){
                isOk = iBorrowCardService.register(borrowCard);
            }
        }

        mapper.writeValue(resp.getWriter(), isOk);
    }
}
