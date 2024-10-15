package Service.impl;

import Bean.*;
import Dao.IAdminDao;
import Dao.IBorrowCardDao;
import Dao.IDepartmentDao;
import Dao.IRoleDao;
import Dao.impl.AdminDao;
import Dao.impl.BorrowCardDao;
import Dao.impl.DepartmentDao;
import Dao.impl.RoleDao;
import Service.IAdminService;
import Util.MySQLUtil;
import Util.PageTable;

import java.util.List;

public class AdminService implements IAdminService {
    private IAdminDao iAdminDao = new AdminDao();
    @Override
    public Admin loginAdmin(Admin admin) {
        return iAdminDao.loginAdmin(admin);
    }

    @Override
    public Admin selAll(String id) {
        return iAdminDao.selAll(id);
    }

    @Override
    public Boolean add(String id) {
        IBorrowCardDao iBorrowCardDao = new BorrowCardDao();
        BorrowCard borrowCard = iBorrowCardDao.selUser(id);
        iBorrowCardDao.authorization(borrowCard.getId(), 1);
        return iAdminDao.add(borrowCard);
    }

    @Override
    public PageTable selPage(UserQuery userQuery) {
        Integer integer = iAdminDao.selPageCount(userQuery);
        int Page = (userQuery.getPage() - 1) * 10;
        userQuery.setPage(Page);
        List<Admin> admins = iAdminDao.selPage(userQuery);
        return new PageTable(0, "", integer, admins);
    }

    @Override
    public Boolean del(String id) {
        IBorrowCardDao iBorrowCardDao = new BorrowCardDao();
        Admin admin = iAdminDao.selAll(id);
        BorrowCard borrowCard = iBorrowCardDao.selUser(admin.getAdminCardNum());
        iBorrowCardDao.authorization(Integer.valueOf(borrowCard.getId()), 0);
        return iAdminDao.del(id);
    }

    @Override
    public Boolean delAll(String[] ids) {
        IBorrowCardDao iBorrowCardDao = new BorrowCardDao();
        Boolean del = false;
        for (String id : ids) {
            Admin admin = iAdminDao.selAll(id);
            BorrowCard borrowCard = iBorrowCardDao.selUser(admin.getAdminCardNum());
            iBorrowCardDao.authorization(Integer.valueOf(borrowCard.getId()), 0);
            del = iAdminDao.del(id);
        }
        return del;
    }

    @Override
    public Boolean isStop(Integer id, String isStop) {
        Admin admin = iAdminDao.selAll(String.valueOf(id));
        IBorrowCardDao iBorrowCardDao = new BorrowCardDao();
        BorrowCard borrowCard = iBorrowCardDao.selUser(admin.getAdminCardNum());
        System.out.println("isStop => "+isStop);
        if ("0".equals(isStop)){
            iBorrowCardDao.authorization(Integer.valueOf(borrowCard.getId()), 0);
        }else if ("1".equals(isStop)){
            iBorrowCardDao.authorization(Integer.valueOf(borrowCard.getId()), 1);
        }
        return iAdminDao.isStop(id, isStop);
    }
}
