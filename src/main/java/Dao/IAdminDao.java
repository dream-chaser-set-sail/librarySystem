package Dao;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.Role;
import Bean.UserQuery;

import java.util.List;

public interface IAdminDao {
    Admin loginAdmin(Admin admin);
    Admin selAll(String id);
    Boolean add(BorrowCard borrowCard);
    Integer selPageCount(UserQuery userQuery);
    List<Admin> selPage(UserQuery userQuery);
    Boolean del(String id);
    Boolean isStop(Integer id, String isStop);
}
