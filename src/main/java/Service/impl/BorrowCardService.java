package Service.impl;

import Bean.*;
import Dao.IBorrowCardDao;
import Dao.IDepartmentDao;
import Dao.IRoleDao;
import Dao.impl.BorrowCardDao;
import Dao.impl.DepartmentDao;
import Dao.impl.RoleDao;
import Service.IBorrowCardService;
import Util.PageTable;

import java.util.List;
import java.util.UUID;

public class BorrowCardService implements IBorrowCardService {
    public IBorrowCardDao iBorrowCardDao = new BorrowCardDao();
    @Override
    public Boolean register(BorrowCard borrowCard) {
        borrowCard.setBorrowCardNum(BorrowCardNum());
        System.out.println(borrowCard);
        return iBorrowCardDao.register(borrowCard);
    }

    @Override
    public BorrowCard loginBorrowCard(Admin admin) {
        return iBorrowCardDao.loginBorrow(admin);
    }

    @Override
    public Boolean selAdminCardNum(String cardNum) {
        Boolean isOk = false;
        Admin admin = iBorrowCardDao.selAdminCardNum(cardNum);

        if (admin != null){
            if (admin.getAdminCardNum().equalsIgnoreCase(cardNum) && admin.getStatus() != 0){
                isOk = true;
            }
        }

        return isOk;
    }

    @Override
    public PageTable selPage(UserQuery userQuery) {
        Integer integer = iBorrowCardDao.selPageCount(userQuery);
        int Page = (userQuery.getPage() - 1) * 10;
        userQuery.setPage(Page);
        List<BorrowCard> borrowCards = iBorrowCardDao.selPage(userQuery);
        IRoleDao iRoleDao = new RoleDao();
        IDepartmentDao iDepartmentDao = new DepartmentDao();

        List<Role> roles = iRoleDao.selAll();
        List<Department> departments = iDepartmentDao.selAll();

        for (int i = 0; i < borrowCards.size(); i++) {
            Integer role = borrowCards.get(i).getRole();
            borrowCards.get(i).setRoleName(roles.get(role-1).getName());
        }
        for (int i = 0; i < borrowCards.size(); i++) {
            Integer role = borrowCards.get(i).getUnit();
            borrowCards.get(i).setUnitName(departments.get(role-1).getName());
        }

        return new PageTable(0, "", integer, borrowCards);
    }

    @Override
    public Boolean del(String id) {
        return iBorrowCardDao.del(id);
    }

    @Override
    public Boolean delAll(String[] ids) {
        Boolean del = false;
        for (String id : ids) {
            del = iBorrowCardDao.del(id);
        }
        return del;
    }

    @Override
    public BorrowCard selOwn(String id) {
        return iBorrowCardDao.selOwn(id);
    }

    @Override
    public Boolean update(BorrowCard borrowCard) {
        if (borrowCard.getRole() == 1){
            borrowCard.setPermission(10);
        }else if (borrowCard.getRole() == 2){
            borrowCard.setPermission(5);
        }else {
            borrowCard.setPermission(1);
        }

        return iBorrowCardDao.update(borrowCard);
    }

    @Override
    public BorrowCard selUser(String id) {
        IDepartmentDao iDepartmentDao = new DepartmentDao();
        IRoleDao iRoleDao = new RoleDao();

        BorrowCard borrowCards = iBorrowCardDao.selUser(id);
        List<Department> departments = iDepartmentDao.selAll();
        List<Role> roles = iRoleDao.selAll();

        for (int i = 0; i < departments.size(); i++) {
            if (borrowCards.getUnit() == departments.get(i).getId()){
                borrowCards.setUnitName(departments.get(i).getName());
            }
        }
        for (int i = 0; i < roles.size(); i++) {
            if (borrowCards.getRole() == roles.get(i).getId()){
                borrowCards.setRoleName(roles.get(i).getName());
            }
        }
        return borrowCards;
    }

    @Override
    public Boolean upByself(BorrowCard borrowCard) {
        return iBorrowCardDao.upByself(borrowCard);
    }

    // 生成卡号
    public String BorrowCardNum(){
        String uuid = String.valueOf(UUID.randomUUID());
        uuid = uuid.replaceAll("-", "");
        uuid = uuid.replaceAll("[^0-9]", "");
        uuid = uuid.substring(0,11);

        List<BorrowCard> borrowCards = iBorrowCardDao.selBorrowCardNum();

        if (borrowCards.size() == 0){
            return uuid;
        }else {
            for (int i = 0; i < borrowCards.size(); i++) {
                String cardNum = borrowCards.get(i).getBorrowCardNum();
                if (!uuid.equals(cardNum)){
                    System.out.println(true);
                    return uuid;
                }else {
                    BorrowCardNum();
                }
            }
        }
        return null;
    }
}
