package Bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginLog {
    private String userId;
    private String userName;
    private String ip;
    private Integer role;
    private Integer unit;
}
