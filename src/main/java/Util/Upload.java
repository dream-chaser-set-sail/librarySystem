package Util;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;

@WebServlet("/upload")
public class Upload extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //1.DiskFileItemFactory磁盘文件项工厂：一些配置的设置，缓存的大小，临时文件位置
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //1M=1024KB  1KB=1024B
        //设置缓存大小
        factory.setSizeThreshold(10 * 1024 * 1024);
        String tempPath = getServletContext().getRealPath("temp");
        //设置临时文件
        factory.setRepository(new File(tempPath));

        //2.文件上传的核心类
        ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
        //设置文件上传名的编码方式
        servletFileUpload.setHeaderEncoding("UTF-8");
        String fileName = "";
        if (ServletFileUpload.isMultipartContent(req)) {
            try {

                List<FileItem> fileItems = servletFileUpload.parseRequest(req);
                if (fileItems != null) {
                    for (FileItem fileItem : fileItems) {
                        //如果是普通表单项，就不做处理
                        if (!fileItem.isFormField()) {//文件上传
                            //fileItem封装了前台传递过来的文件上传的信息
                            //abc.png
                            String name = fileItem.getName();
                            String uuid = UUID.randomUUID().toString().replace("-", "");
                            //2a66c4f8b84b4ebdb4a4ede3e715d0a1.png
                            String extension = FilenameUtils.getExtension(name);
                            fileName = uuid + "." + extension;
                            InputStream inputStream = fileItem.getInputStream();
                            OutputStream outputStream = new FileOutputStream("C:/Users/Dell/Desktop/Project/LIbrary/img/" + fileName);
                            IOUtils.copy(inputStream, outputStream);
                            outputStream.close();
                            inputStream.close();
                            //删除临时文件
                            fileItem.delete();
                        }
                    }
                }

            }catch (FileUploadException e){
                throw new RuntimeException(e);
            }

            Map<String, Object> map = new HashMap<>();
            Boolean isOk = false;
            if (fileName != null && !"".equals(fileName)){
                isOk = true;
            }
            map.put("imgName",fileName);
            map.put("result",isOk);
            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValue(resp.getWriter(),map);
        }
    }
}
