package Service.impl;

import Bean.*;
import Dao.*;
import Dao.impl.*;
import Service.IBookService;
import Service.IBorrowCardService;
import Util.BookExcelListener;
import Util.ExcelUtil;
import Util.PageTable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;

public class BookService implements IBookService {
    private IBookDao iBookDao = new BookDao();
    @Override
    public PageTable selPage(UserQuery userQuery) {
        Integer integer = iBookDao.selPageCount(userQuery);
        int Page = (userQuery.getPage() - 1) * 10;
        userQuery.setPage(Page);
        List<Books> books = iBookDao.selPage(userQuery);
        return new PageTable(0, "", integer, books);
    }

    @Override
    public Boolean delAll(String[] ids) {
        Boolean del = false;
        for (String id : ids) {
            del = iBookDao.del(id);
        }
        return del;
    }

    @Override
    public Boolean del(String id) {
        return iBookDao.del(id);
    }

    @Override
    public Books selOwn(String id) {
        return iBookDao.selOwn(id);
    }

    @Override
    public Boolean update(Books books) {
        return iBookDao.update(books);
    }

    @Override
    public Boolean add(Books books) {
        return iBookDao.add(books);
    }

    @Override
    public Boolean isTop(Integer id, String isTop) {
        return iBookDao.isTop(id, isTop);
    }

    @Override
    public List<Books> borrowBook(String id) {
        return iBookDao.borrowBook(id);
    }

    @Override
    public Books selBookByisbn(String id,String isbn) {
        IBorrowBookDao iBorrowBookDao = new BorrowBookDao();
        IBorrowCardDao iBorrowCardDao = new BorrowCardDao();
        List<BorrowBooks> borrowBooks = iBorrowBookDao.selAllById(id);
        Books books = iBookDao.selBookByisbn(isbn);
        Integer borrowBookNum = iBorrowBookDao.borrowBookNum(id);
        BorrowCard borrowCard = iBorrowCardDao.selUser(id);

        if (borrowBookNum != borrowCard.getPermission()) {
            if (!borrowBooks.isEmpty()) {
                // 借阅过书
                Boolean hasUnreturned = false;
                for (BorrowBooks borrowBook : borrowBooks) {
                    // 此用户借过的所有的书
                    if (borrowBook.getIsbn().equals(books.getIsbn())) {
                        // 用户借过此书
                        if (borrowBook.getStatus() != 1) {
                            // 未归还
                            hasUnreturned = true;
                            break;
                        }
                    }
                }

                if (hasUnreturned) {
                    books.setStatus(2);
                } else {
                    // 结过此书且已归还
                    books.setStatus(1);
                }
            } else {
                // 未借阅过任何书
                books.setStatus(1);
            }
        } else {
            books.setStatus(2);
        }
        return books;
    }

    @Override
    public List<Books> selTop() {
        return iBookDao.selTop();
    }

    @Override
    public List<Books> selClick() {
        return iBookDao.selClick();
    }

    @Override
    public void exportExcel(HttpServletResponse resp) {
        List<BooksExcel> booksExcelList = iBookDao.selectAll();
        ExcelUtil.exportExcel(resp,booksExcelList, BooksExcel.class, "Books");
    }

    @Override
    public String importExcel(HttpServletRequest req) {
        ExcelUtil.importExcel(req, new BookExcelListener(), BooksExcel.class);
        return null;
    }
}
