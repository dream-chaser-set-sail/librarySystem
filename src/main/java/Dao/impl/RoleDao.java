package Dao.impl;

import Bean.Role;
import Dao.IRoleDao;
import Util.MySQLUtil;

import java.util.List;

public class RoleDao implements IRoleDao {
    @Override
    public List<Role> selAll() {
        String sql = "SELECT * FROM roles";
        return MySQLUtil.SELECT(sql, Role.class, null);
    }
}
