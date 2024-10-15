package Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

@WebServlet("/page/*")
public class PageServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestURI = req.getRequestURI();
        System.out.println(requestURI);

        String[] paths = requestURI.split("/");
        System.out.println(Arrays.toString(paths));

        if (paths.length == 4){
            req.getRequestDispatcher("/WEB-INF/"+paths[2]+"_"+paths[3]+".jsp").forward(req,resp);
        }else if (paths.length == 3){
            req.getRequestDispatcher("/WEB-INF/"+paths[2]+".jsp").forward(req,resp);
        }else if (paths.length == 5){
            req.getRequestDispatcher("/WEB-INF/"+paths[3]+"/"+paths[4]+".jsp").forward(req,resp);
        }else if (paths.length == 6){
            req.getRequestDispatcher("/WEB-INF/"+paths[3]+"/"+paths[4]+"_"+paths[5]+".jsp").forward(req,resp);
        }
    }
}
