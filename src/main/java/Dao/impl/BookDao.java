package Dao.impl;

import Bean.*;
import Dao.IBookDao;
import Dao.IBorrowCardDao;
import Util.MySQLUtil;

import java.util.ArrayList;
import java.util.List;

public class BookDao implements IBookDao {

    @Override
    public Integer selPageCount(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM book WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getName()) && userQuery.getName() != null){
            sql += " AND name LIKE ?";
            list.add("%"+userQuery.getName()+"%");
        }
        if (!"".equalsIgnoreCase(userQuery.getTypeUnit()) && userQuery.getTypeUnit() != null){
            sql += " AND book_type = ?";
            list.add(userQuery.getTypeUnit());
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())){
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }

        return MySQLUtil.SELECTCOUNT(sql, list, null);
    }

    @Override
    public List<Books> selPage(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT b.*, t.`name` 'bookTypeName' FROM book b, book_classify t WHERE b.book_type = t.id";
        if (!"".equalsIgnoreCase(userQuery.getName()) && userQuery.getName() != null){
            sql += " AND b.name LIKE ?";
            list.add("%"+userQuery.getName()+"%");
        }
        if (!"".equalsIgnoreCase(userQuery.getTypeUnit()) && userQuery.getTypeUnit() != null){
            sql += " AND b.book_type = ?";
            list.add(userQuery.getTypeUnit());
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())){
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }
        sql += " LIMIT ?,?";
        list.add(userQuery.getPage());
        list.add(userQuery.getLimit());

        return MySQLUtil.SELECT(sql, Books.class, list);
    }

    @Override
    public Boolean del(String id) {
        String sql = "DELETE FROM book WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, id);
    }

    @Override
    public Books selOwn(String id) {
        String sql = "SELECT * FROM book WHERE id = ?";
        return MySQLUtil.SELECTone(sql, Books.class, id);
    }

    @Override
    public Boolean update(Books books) {
        String sql = "UPDATE book SET name = ?, author = ?, synopsis = ?, publishing_house = ?, price = ?, amount = ?, image = ?, book_type = ? WHERE id = ? ";
        return MySQLUtil.UPDATE(sql, null, books.getName(), books.getAuthor(), books.getSynopsis(), books.getPublishingHouse(), books.getPrice(), books.getAmount(), books.getImage(), books.getBookType(), books.getId());
    }

    @Override
    public Boolean add(Books books) {
        String sql = "INSERT INTO book (name, isbn, synopsis, author, publishing_house, price, amount, image, book_type) VALUES(?,?,?,?,?,?,?,?,?)";
        return MySQLUtil.UPDATE(sql, null, books.getName(), books.getIsbn(), books.getSynopsis(), books.getAuthor(), books.getPublishingHouse(), books.getPrice(), books.getAmount(), books.getImage(), books.getBookType());
    }

    @Override
    public Boolean isTop(Integer id, String isTop) {
        String sql = "UPDATE book SET ontop = ? WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, isTop, id);
    }

    @Override
    public List<Books> borrowBook(String id) {
        String sql = "SELECT b.*, n.status 'status', n.endTime 'endTime' FROM borrow_books n, borrow_cards c, book b WHERE c.borrow_card_num = n.borrow_card_num AND n.isbn = b.isbn AND n.status != 1 AND c.borrow_card_num = ?";
        return MySQLUtil.SELECT(sql, Books.class, null, id);
    }

    @Override
    public Books selBookByisbn(String isbn) {
        String sql = "SELECT b.*, t.name 'bookTypeName' FROM book b, book_classify t WHERE b.book_type = t.id AND isbn = ?";
        return MySQLUtil.SELECTone(sql, Books.class, isbn);
    }

    @Override
    public List<Books> selTop() {
        String sql = "SELECT * FROM book WHERE ontop = 1";
        return MySQLUtil.SELECT(sql, Books.class, null);
    }

    @Override
    public List<Books> selClick() {
        String sql = "SELECT * FROM book ORDER BY onclick_num DESC LIMIT 0,3";
        return MySQLUtil.SELECT(sql, Books.class, null);
    }

    @Override
    public List<BooksExcel> selectAll() {
        String sql = "SELECT b.*, t.name 'bookTypeName' FROM book b, book_classify t WHERE b.book_type = t.id";
        return MySQLUtil.SELECT(sql, BooksExcel.class, null);
    }

    @Override
    public void addExcel(BooksExcel booksExcel) {
        String sql = "INSERT INTO book (name, isbn, synopsis, author, publishing_house, book_type, price, amount) VALUES(?,?,?,?,?,?,?,?)";
        MySQLUtil.UPDATE(sql, null, booksExcel.getName(), booksExcel.getIsbn(), booksExcel.getSynopsis(), booksExcel.getAuthor(), booksExcel.getPublishingHouse(), booksExcel.getBookType(), booksExcel.getPrice(), booksExcel.getAmount());
    }
}
