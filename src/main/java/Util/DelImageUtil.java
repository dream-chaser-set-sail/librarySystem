package Util;

import java.io.File;

public class DelImageUtil {
    public static Boolean DelImg(String imgName){
        Boolean isOk = false;

        // 图片文件路径
        String filePath = "C:/Users/Dell/Desktop/Project/LIbrary/img/" + imgName;

        // 创建 File 对象
        File file = new File(filePath);

        // 删除文件
        if (file.delete()) {
            isOk = true;
            System.out.println("文件已删除");
        } else {
            System.out.println("文件删除失败");
        }

        return isOk;
    }
}
