package Bean;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BooksExcel {
    @ExcelProperty(value = "ID")
    private Integer id;
    @ExcelProperty(value = "书名")
    private String name;
    @ExcelProperty(value = "书号")
    private String isbn;
    @ExcelProperty(value = "书籍简介")
    private String synopsis;
    @ExcelIgnore
    private Integer ontop;
    @ExcelIgnore
    private Integer onclickNum;
    @ExcelProperty(value = "作者")
    private String author;
    @ExcelProperty(value = "出版社")
    private String publishingHouse;
    @ExcelIgnore
    private Integer bookType;
    @ExcelProperty(value = "书籍标签")
    private String bookTypeName;
    @ExcelIgnore
    private String image;
    @ExcelProperty(value = "价格")
    private Double price;
    @ExcelProperty(value = "数量")
    private Integer amount;
    @ExcelProperty(value = "入库时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
}
