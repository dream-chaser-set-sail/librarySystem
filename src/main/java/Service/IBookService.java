package Service;

import Bean.Admin;
import Bean.Books;
import Bean.BorrowCard;
import Bean.UserQuery;
import Util.PageTable;

import java.util.List;

public interface IBookService {
    PageTable selPage(UserQuery userQuery);
    Boolean delAll(String[] ids);
    Boolean del(String id);
    Books selOwn(String id);
    Boolean update(Books books);
    Boolean add(Books books);
    Boolean isTop(Integer id, String isTop);
    List<Books> borrowBook(String id);
    Books selBookByisbn(String id, String isbn);
    List<Books> selTop();
    List<Books> selClick();
}
