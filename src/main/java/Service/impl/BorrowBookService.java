package Service.impl;

import Bean.*;
import Dao.IBookClassifyDao;
import Dao.IBorrowBookDao;
import Dao.impl.BookClassifyDao;
import Dao.impl.BorrowBookDao;
import Service.IBorrowBookService;
import Util.ComputingTimeUtil;
import Util.MySQLUtil;
import Util.PageTable;
import Util.ScheduledTask;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BorrowBookService implements IBorrowBookService {
    private IBorrowBookDao iBorrowBookDao = new BorrowBookDao();
    private final ScheduledTask scheduledTask = new ScheduledTask(); // 初始化借书任务调度器

    @Override
    public PageTable selPage(UserQuery userQuery) {
        Integer integer = iBorrowBookDao.selPageCount(userQuery);
        int Page = (userQuery.getPage() - 1) * 10;
        userQuery.setPage(Page);
        List<BorrowBooks> borrowCards = iBorrowBookDao.selPage(userQuery);
        return new PageTable(0, "", integer, borrowCards);
    }

    @Override
    public Boolean delAll(String[] ids) {
        Boolean del = false;
        for (String id : ids) {
            del = iBorrowBookDao.del(id);
        }
        return del;
    }

    @Override
    public Boolean del(String id) {
        return iBorrowBookDao.del(id);
    }

    @Override
    public Integer borrowBookNum(String id) {
        return iBorrowBookDao.borrowBookNum(id);
    }

    @Override
    public List<Books> selBook(String id) {
        return iBorrowBookDao.selBook(id);
    }

    @Override
    public Boolean returnBook(String bid, String uid) {
        Integer 总数 = MySQLUtil.SELECTCOUNT("SELECT COUNT(*) '总数' FROM borrow_books WHERE borrow_card_num = ? AND `status` = 2", null, "总数", uid);
        System.out.println("总数: "+ (总数 - 1));
        if ((总数-1) == 0) {
            MySQLUtil.UPDATE("UPDATE borrow_cards SET status = 1  WHERE borrow_card_num = ?", null, uid);
        }

        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDate = formatter.format(date);
        MySQLUtil.UPDATE("UPDATE book SET amount = amount + 1  WHERE isbn = ?", null, bid);
        MySQLUtil.UPDATE("UPDATE borrow_cards SET borrowed_books_num = borrowed_books_num - 1  WHERE borrow_card_num = ?", null, uid);
        return iBorrowBookDao.returnBook(formattedDate, bid, uid);
    }

    @Override
    public Boolean renewal(Integer addNum, String isbn, String borrowCardNum) {
        String nowTime = ComputingTimeUtil.extensionOfvalidity(new Date(), addNum);
        System.out.println("续期时间 => "+nowTime);
        return iBorrowBookDao.renewal(nowTime, isbn, borrowCardNum);
    }

    @Override
    public Map<String, Object> add(String uid, String isbn, Integer addNum) {
        Map<String, Object> map = new HashMap<>();
        String hint = "";
        Boolean isOk = false;
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createTime = formatter.format(date);
        String endTime = ComputingTimeUtil.extensionOfvalidity(date, addNum);

        long endTimeMillis = 0;
        try {
            endTimeMillis = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(endTime).getTime();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        // 查询书籍信息
        List<BorrowBooks> borrowBooks = iBorrowBookDao.selAllById(uid);
        boolean hasMatched = false;  // 标志位
        if (!borrowBooks.isEmpty()) {
            for (BorrowBooks borrowBook : borrowBooks) {
                if (borrowBook.getIsbn().equals(isbn)) {
                    isOk = iBorrowBookDao.addBook(isbn, uid, endTime);
                    MySQLUtil.UPDATE("UPDATE book SET onclick_num = onclick_num + 1  WHERE isbn = ?", null, isbn);
                    MySQLUtil.UPDATE("UPDATE book SET amount = amount - 1  WHERE isbn = ?", null, isbn);
                    MySQLUtil.UPDATE("UPDATE borrow_cards SET borrowed_books_num = borrowed_books_num + 1  WHERE borrow_card_num = ?", null, uid);
                    MySQLUtil.UPDATE("UPDATE borrow_cards SET status = 2  WHERE borrow_card_num = ?", null, uid);
                    hint = scheduledTask.scheduleBorrowTask(uid, isbn, endTimeMillis);// 安排还书提醒
                    hasMatched = true;  // 已找到匹配的 ISBN
                    break;  // 找到后退出循环
                }
            }
        }
        // 如果没有找到匹配的 ISBN，则执行添加操作
        if (!hasMatched) {
            isOk = iBorrowBookDao.add(uid, isbn, createTime, endTime);
            MySQLUtil.UPDATE("UPDATE book SET amount = amount - 1  WHERE isbn = ?", null, isbn);
            MySQLUtil.UPDATE("UPDATE book SET onclick_num = onclick_num + 1  WHERE isbn = ?", null, isbn);
            MySQLUtil.UPDATE("UPDATE borrow_cards SET borrowed_books_num = borrowed_books_num + 1  WHERE borrow_card_num = ?", null, uid);
            hint = scheduledTask.scheduleBorrowTask(uid, isbn, endTimeMillis);// 安排还书提醒
        }

        map.put("isOk", isOk);
        map.put("hint", hint);
        return map;
    }

    // 关闭调度器的方法
    public void shutdownScheduler() {
        scheduledTask.shutdown(); // 关闭借书任务调度器
    }
}
