package Service.impl;

import Bean.BookClassifys;
import Dao.IBookClassifyDao;
import Dao.impl.BookClassifyDao;
import Service.IBookClassifyService;

import java.util.List;

public class BookClassifyService implements IBookClassifyService {
    private IBookClassifyDao iBookClassifyDao = new BookClassifyDao();

    @Override
    public List<BookClassifys> selAll() {
        return iBookClassifyDao.selAll();
    }
}
