package Bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Books {
    private Integer id;
    private String name;
    private String isbn;
    private String synopsis;
    private String author;
    private String publishingHouse;
    private Integer bookType;
    private String bookTypeName;
    private String image;
    private Double price;
    private Integer amount;
    private Integer ontop;
    private Integer onclickNum;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    private Integer status;
    private String endTime;
}
