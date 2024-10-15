package Util;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageTable<T> {
    private Integer code;
    private String msg;
    private Integer count;
    private List<T> data;
}
