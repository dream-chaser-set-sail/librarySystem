package Dao;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.UserQuery;
import Util.PageTable;

import java.util.List;

public interface IBorrowCardDao {
    Boolean register(BorrowCard borrowCard);
    BorrowCard loginBorrow(Admin admin);
    List<BorrowCard> selBorrowCardNum(); // 查询卡号
    Admin selAdminCardNum(String cardNum);
    Integer selPageCount(UserQuery userQuery);
    List<BorrowCard> selPage(UserQuery userQuery);
    Boolean del(String id);
    BorrowCard selOwn(String id);
    Boolean update(BorrowCard borrowCard);
    Boolean authorization(Integer id, Integer isAdmin);
    BorrowCard selUser(String id);
    Boolean upByself(BorrowCard borrowCard);
}
