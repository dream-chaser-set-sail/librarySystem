package Bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BorrowBooks {
    private Integer id;
    private String isbn;
    private Integer status;
    private String borrowCardNum;
    private String createTime;
    private String endTime;
}
