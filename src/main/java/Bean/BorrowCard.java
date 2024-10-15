package Bean;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BorrowCard {
    private Integer id;
    private String borrowCardNum;
    private String name;
    private String image;
    private Integer unit;
    private Integer role;
    private String unitName;
    private String roleName;
    private Integer status;
    private Integer permission;
    private Integer borrowedBooksNum;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    private Integer creditScore;
    private Integer adminStatus;
}
