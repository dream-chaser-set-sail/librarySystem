package Dao.impl;

import Bean.BookClassifys;
import Bean.Role;
import Dao.IBookClassifyDao;
import Service.IBookClassifyService;
import Util.MySQLUtil;

import java.util.List;

public class BookClassifyDao implements IBookClassifyDao {

    @Override
    public List<BookClassifys> selAll() {
        String sql = "SELECT * FROM book_classify";
        return MySQLUtil.SELECT(sql, BookClassifys.class, null);
    }
}
