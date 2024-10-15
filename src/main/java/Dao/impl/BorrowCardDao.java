package Dao.impl;

import Bean.Admin;
import Bean.BorrowCard;
import Bean.UserQuery;
import Dao.IBorrowCardDao;
import Util.MyBeanUtil;
import Util.MySQLUtil;
import Util.PageTable;

import java.util.ArrayList;
import java.util.List;

public class BorrowCardDao implements IBorrowCardDao {
    @Override
    public Boolean register(BorrowCard borrowCard) {
        String sql = "INSERT INTO borrow_cards (borrow_card_num, `name`, image, unit, role) VALUES(?, ?, ?, ?, ?)";
        return MySQLUtil.UPDATE(sql, null, borrowCard.getBorrowCardNum(), borrowCard.getName(), borrowCard.getImage()
                ,borrowCard.getUnit(), borrowCard.getRole());
    }

    @Override
    public BorrowCard loginBorrow(Admin admin) {
        String sql = "SELECT * FROM borrow_cards WHERE borrow_card_num = ? AND `name` = ?";
        return MySQLUtil.SELECTone(sql, BorrowCard.class, admin.getAdminCardNum(), admin.getName());
    }

    // 查询卡号
    @Override
    public List<BorrowCard> selBorrowCardNum() {
        String sql = "SELECT borrow_card_num FROM borrow_cards";
        return MySQLUtil.SELECT(sql, BorrowCard.class, null);
    }

    @Override
    public Admin selAdminCardNum(String cardNum) {
        String sql = "SELECT admin_card_num, status FROM admin WHERE admin_card_num = ?";
        return MySQLUtil.SELECTone(sql, Admin.class, cardNum);
    }

    @Override
    public Integer selPageCount(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM borrow_cards WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getName()) && userQuery.getName() != null){
            sql += " AND name LIKE ?";
            list.add("%"+userQuery.getName()+"%");
        }
        if (!"".equalsIgnoreCase(userQuery.getTypeUnit()) && userQuery.getTypeUnit() != null){
            sql += " AND unit = ?";
            list.add(userQuery.getTypeUnit());
        }
        if (!"".equalsIgnoreCase(userQuery.getTypeRole()) && userQuery.getTypeRole() != null){
            sql += " AND role = ?";
            list.add(userQuery.getTypeRole());
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())){
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }

        return MySQLUtil.SELECTCOUNT(sql, list, null);
    }

    @Override
    public List<BorrowCard> selPage(UserQuery userQuery) {
        List<Object> list = new ArrayList<>();
        String sql = "SELECT * FROM borrow_cards WHERE 1=1";
        if (!"".equalsIgnoreCase(userQuery.getName()) && userQuery.getName() != null){
            sql += " AND name LIKE ?";
            list.add("%"+userQuery.getName()+"%");
        }
        if (!"".equalsIgnoreCase(userQuery.getTypeUnit()) && userQuery.getTypeUnit() != null){
            sql += " AND unit = ?";
            list.add(userQuery.getTypeUnit());
        }
        if (!"".equalsIgnoreCase(userQuery.getTypeRole()) && userQuery.getTypeRole() != null){
            sql += " AND role = ?";
            list.add(userQuery.getTypeRole());
        }
        if (userQuery.getCreateTime() != null && !"".equalsIgnoreCase(userQuery.getCreateTime()) && userQuery.getUpdateTime() != null && !"".equalsIgnoreCase(userQuery.getUpdateTime())){
            sql += " AND createTime BETWEEN ? AND ?";
            list.add(userQuery.getCreateTime());
            list.add(userQuery.getUpdateTime());
        }
        sql += " LIMIT ?,?";
        list.add(userQuery.getPage());
        list.add(userQuery.getLimit());

        return MySQLUtil.SELECT(sql, BorrowCard.class, list);
    }

    @Override
    public Boolean del(String id) {
        String sql = "DELETE FROM borrow_cards WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, id);
    }

    @Override
    public BorrowCard selOwn(String id) {
        String sql = "SELECT * FROM borrow_cards WHERE id = ?";
        return MySQLUtil.SELECTone(sql, BorrowCard.class, id);
    }

    @Override
    public Boolean update(BorrowCard borrowCard) {
        String sql = "UPDATE borrow_cards SET name = ?, image = ?, unit = ?, role = ?, permission = ? WHERE id = ? ";
        return MySQLUtil.UPDATE(sql, null, borrowCard.getName(), borrowCard.getImage(), borrowCard.getUnit(), borrowCard.getRole(), borrowCard.getPermission(), borrowCard.getId());
    }

    @Override
    public Boolean authorization(Integer id, Integer isAdmin) {
        String sql = "UPDATE borrow_cards SET admin_status = ? WHERE id = ?";
        return MySQLUtil.UPDATE(sql, null, isAdmin, id);
    }

    @Override
    public BorrowCard selUser(String id) {
        String sql = "SELECT * FROM borrow_cards WHERE borrow_card_num = ?";
        return MySQLUtil.SELECTone(sql, BorrowCard.class, id);
    }

    @Override
    public Boolean upByself(BorrowCard borrowCard) {
        List<Object> list = new ArrayList<>();
        String sql = "UPDATE borrow_cards SET";
        if (!borrowCard.getName().equals("") && borrowCard.getName() != null){
            sql += " name = ?,";
            list.add(borrowCard.getName());
        }
        if (borrowCard.getRole() != null){
            sql += " role = ?,";
            list.add(borrowCard.getRole());
        }
        if (borrowCard.getRole() == 2){
            sql += " permission = 5,";
        }
        if (borrowCard.getRole() == 1){
            sql += " permission = 10,";
        }
        if (borrowCard.getRole() == 3){
            sql += " permission = 1,";
        }
        if (borrowCard.getUnit() != null){
            sql += " unit = ?,";
            list.add(borrowCard.getUnit());
        }
        sql += "WHERE borrow_card_num = ?";
        list.add(borrowCard.getBorrowCardNum());
        String cleanedSql = sql.replace(",WHERE", " WHERE");

        return MySQLUtil.UPDATE(cleanedSql, list);
    }
}
