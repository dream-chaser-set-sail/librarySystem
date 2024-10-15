package Service;

import Bean.Books;
import Bean.UserQuery;
import Util.PageTable;

import java.util.List;
import java.util.Map;

public interface IBorrowBookService {
    PageTable selPage(UserQuery userQuery);
    Boolean delAll(String[] ids);
    Boolean del(String id);
    Integer borrowBookNum(String id);
    List<Books> selBook(String id);
    Boolean returnBook(String bid, String uid);
    Boolean renewal(Integer addNum, String isbn, String borrowCardNum);
    Map<String,Object> add(String uid, String isbn, Integer addNum);
}
