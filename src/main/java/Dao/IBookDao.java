package Dao;

import Bean.*;

import java.util.List;

public interface IBookDao {
    Integer selPageCount(UserQuery userQuery);
    List<Books> selPage(UserQuery userQuery);
    Boolean del(String id);
    Books selOwn(String id);
    Boolean update(Books books);
    Boolean add(Books books);
    Boolean isTop(Integer id, String isTop);
    List<Books> borrowBook(String id);
    Books selBookByisbn(String isbn);
    List<Books> selTop();
    List<Books> selClick();
    List<BooksExcel> selectAll();

}
