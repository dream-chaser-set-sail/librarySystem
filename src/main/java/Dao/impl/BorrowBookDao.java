package Dao.impl;


import Bean.Books;
import Bean.BorrowBooks;
import Bean.BorrowCard;
import Bean.UserQuery;
import Dao.IBorrowBookDao;
import Util.MySQLUtil;

import java.util.ArrayList;
import java.util.List;

public class BorrowBookDao implements IBorrowBookDao {
    @Override
    public Integer selPageCount(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM borrow_books WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getIsbn()) && userQuery.getIsbn() != null) {
            sql += " AND isbn = ?";
            list.add(userQuery.getIsbn());
        }
        if (!"".equalsIgnoreCase(userQuery.getBorrowCardNum()) && userQuery.getBorrowCardNum() != null) {
            sql += " AND borrow_card_num = ?";
            list.add(userQuery.getBorrowCardNum());
        }
        if (userQuery.getStatus() != null) {
            sql += " AND status = ?";
            list.add(userQuery.getStatus());
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())) {
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }

        return MySQLUtil.SELECTCOUNT(sql, list, null);
    }

    @Override
    public List<BorrowBooks> selPage(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT * FROM borrow_books WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getIsbn()) && userQuery.getIsbn() != null) {
            sql += " AND isbn = ?";
            list.add(userQuery.getIsbn());
        }
        if (!"".equalsIgnoreCase(userQuery.getBorrowCardNum()) && userQuery.getBorrowCardNum() != null) {
            sql += " AND borrow_card_num = ?";
            list.add(userQuery.getBorrowCardNum());
        }
        if (userQuery.getStatus() != null) {
            sql += " AND status = ?";
            list.add(userQuery.getStatus());
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())) {
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }
        sql += " LIMIT ?,?";
        list.add(userQuery.getPage());
        list.add(userQuery.getLimit());

        return MySQLUtil.SELECT(sql, BorrowBooks.class, list);
    }

    @Override
    public Boolean del(String id) {
        String sql = "DELETE FROM borrow_books WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, id);
    }

    @Override
    public Integer borrowBookNum(String id) {
        String sql = "SELECT COUNT(*) '总数' FROM borrow_books WHERE borrow_card_num = ?";
        return MySQLUtil.SELECTCOUNT(sql, null, "总数", id);
    }

    @Override
    public List<Books> selBook(String id) {
        String sql = "SELECT b.*, t.name 'book_type_name' FROM book b, borrow_books s, book_classify t WHERE b.isbn = s.isbn AND b.book_type = t.id AND s.borrow_card_num = ?";
        return MySQLUtil.SELECT(sql, Books.class, null, id);
    }

    @Override
    public Boolean returnBook(String date, String bid, String uid) {
        String sql = "UPDATE borrow_books SET status = 1, endTime = ? WHERE isbn = ? AND borrow_card_num = ?";
        return MySQLUtil.UPDATE(sql, null, date, bid, uid);
    }

    @Override
    public Boolean addBook(String bid, String uid, String endTime) {
        String sql = "UPDATE borrow_books SET status = 2, endTime = ? WHERE isbn = ? AND borrow_card_num = ?";
        return MySQLUtil.UPDATE(sql, null, endTime, bid, uid);
    }

    @Override
    public Boolean renewal(String nowTime, String isbn, String borrowCardNum) {
        String sql = "UPDATE borrow_books SET endTime = ? WHERE isbn = ? AND borrow_card_num = ?";
        return MySQLUtil.UPDATE(sql, null, nowTime, isbn, borrowCardNum);
    }

    @Override
    public List<BorrowBooks> selAllById(String id){
        String sql = "SELECT * FROM borrow_books WHERE borrow_card_num = ?";
        return MySQLUtil.SELECT(sql, BorrowBooks.class, null, id);
    }

    @Override
    public Boolean add(String uid, String isbn, String createTime, String endTime) {
        System.out.println("BorrowBookDao.add");
        String sql = "INSERT INTO borrow_books (isbn, createTime, endTime, borrow_card_num) VALUES(?, ?, ?, ? )";
        return MySQLUtil.UPDATE(sql, null, isbn, createTime, endTime, uid);
    }
}