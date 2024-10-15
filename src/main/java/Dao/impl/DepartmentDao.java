package Dao.impl;

import Bean.Department;
import Dao.IDepartmentDao;
import Util.MySQLUtil;

import java.util.List;

public class DepartmentDao implements IDepartmentDao {
    @Override
    public List<Department> selAll() {
        String sql = "SELECT * FROM department";
        return MySQLUtil.SELECT(sql, Department.class, null);
    }
}
