package Service.impl;

import Bean.Department;
import Dao.IDepartmentDao;
import Dao.impl.DepartmentDao;
import Service.IDepartmentService;

import java.util.List;

public class DepartmentService implements IDepartmentService {
    private IDepartmentDao iDepartmentDao = new DepartmentDao();
    @Override
    public List<Department> selAll() {
       return iDepartmentDao.selAll();
    }
}
