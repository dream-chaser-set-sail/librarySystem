package Service;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.UserQuery;
import Util.PageTable;

import java.util.List;

public interface IBorrowCardService {
    Boolean register(BorrowCard borrowCard);
    BorrowCard loginBorrowCard(Admin admin);
    Boolean selAdminCardNum(String cardNum);
    PageTable selPage(UserQuery userQuery);
    Boolean del(String id);
    Boolean delAll(String[] ids);
    BorrowCard selOwn(String id);
    Boolean update(BorrowCard borrowCard);
    BorrowCard selUser(String id);
    Boolean upByself(BorrowCard borrowCard);
}
