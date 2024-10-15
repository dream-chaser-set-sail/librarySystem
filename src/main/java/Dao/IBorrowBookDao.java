package Dao;


import Bean.Books;
import Bean.BorrowBooks;
import Bean.UserQuery;

import java.util.List;

public interface IBorrowBookDao {
    Integer selPageCount(UserQuery userQuery);
    List<BorrowBooks> selPage(UserQuery userQuery);
    Boolean del(String id);
    Integer borrowBookNum(String id);
    List<Books> selBook(String id);
    Boolean returnBook(String date, String bid, String uid);
    Boolean addBook(String nowTime, String isbn, String borrowCardNum);
    Boolean renewal(String nowTime, String isbn, String borrowCardNum);
    List<BorrowBooks> selAllById(String id);
    Boolean add(String uid, String isbn, String createTime, String endTime);
}
