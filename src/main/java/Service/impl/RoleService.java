package Service.impl;

import Bean.Role;
import Dao.IRoleDao;
import Dao.impl.RoleDao;
import Service.IRoleService;

import java.util.List;

public class RoleService implements IRoleService {
    private IRoleDao iRoleDao = new RoleDao();
    @Override
    public List<Role> selAll() {
        return iRoleDao.selAll();
    }
}
