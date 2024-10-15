package Bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BorrowTask {
    private String uid; // 用户ID
    private String isbn; // 书籍ISBN
    private long endTime; // 还书截止时间（毫秒）
}
