package Util;

import Bean.Admin;
import Bean.BorrowCard;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "login", urlPatterns = "/*")
public class Filters implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String method1 = request.getMethod();
        if ("post".equalsIgnoreCase(method1)){
            servletRequest.setCharacterEncoding("UTF-8");
        }

        System.out.println("Filters.doFilter");
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String uri = ((HttpServletRequest) servletRequest).getRequestURI();
        System.out.println("uri ==> "+uri);
        String method = servletRequest.getParameter("method");
        System.out.println("method => "+method);
        // 需要初始化后直接放行的
        if (uri.startsWith("/static")
                || uri.equals("/page/login")
                || uri.equals("/page/insert")
                || uri.equals("/verifyCode")
                || uri.equals("/upload")
                || "register".equals(method)
                || "selAll".equals(method)
                || "selAdminCardNum".equals(method)
                || "login".equals(method)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        HttpSession session = ((HttpServletRequest) servletRequest).getSession();
        Object isLogin = session.getAttribute("isLogin");
        System.out.println(isLogin);
        if (isLogin == null){
            response.sendRedirect("/page/login");
            return;
        }

        filterChain.doFilter(servletRequest,servletResponse);
    }

    @Override
    public void destroy() {

    }
}
