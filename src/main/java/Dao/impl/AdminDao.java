package Dao.impl;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.Role;
import Bean.UserQuery;
import Dao.IAdminDao;
import Dao.IRoleDao;
import Util.MySQLUtil;

import java.util.ArrayList;
import java.util.List;

public class AdminDao implements IAdminDao {
    @Override
    public Admin loginAdmin(Admin admin) {
        String sql = "SELECT * FROM admin WHERE `name` = ? AND password = ?";
        return MySQLUtil.SELECTone(sql, Admin.class, admin.getName(), admin.getPassword());
    }

    @Override
    public Admin selAll(String id) {
        String sql = "SELECT * FROM admin WHERE id = ?";
        return MySQLUtil.SELECTone(sql, Admin.class, id);
    }

    @Override
    public Boolean add(BorrowCard borrowCard) {
        String sql = "INSERT INTO admin (admin_card_num, name, `password`, image) VALUES(?, ?, 1, ?)";
        return MySQLUtil.UPDATE(sql,null, borrowCard.getBorrowCardNum(), borrowCard.getName(), borrowCard.getImage());
    }

    @Override
    public Integer selPageCount(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM admin WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getName()) && userQuery.getName() != null){
            sql += " AND name LIKE ?";
            list.add("%"+userQuery.getName()+"%");
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())){
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }

        return MySQLUtil.SELECTCOUNT(sql, list, null);
    }

    @Override
    public List<Admin> selPage(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT * FROM admin WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getName()) && userQuery.getName() != null){
            sql += " AND name LIKE ?";
            list.add("%"+userQuery.getName()+"%");
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())){
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }
        sql += " LIMIT ?,?";
        list.add(userQuery.getPage());
        list.add(userQuery.getLimit());

        return MySQLUtil.SELECT(sql, Admin.class, list);
    }

    @Override
    public Boolean del(String id) {
        String sql = "DELETE FROM admin WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, id);
    }

    @Override
    public Boolean isStop(Integer id, String isStop) {
        String sql = "UPDATE admin SET status = ? WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, isStop, id);
    }
}
