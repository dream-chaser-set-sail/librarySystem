package Dao.impl;

import Bean.Role;
import Bean.Status;
import Dao.IStatusDao;
import Service.IStatusService;
import Util.MySQLUtil;

import java.util.List;

public class StatusDao implements IStatusDao {
    @Override
    public List<Status> selAll() {
        String sql = "SELECT * FROM status";
        return MySQLUtil.SELECT(sql, Status.class, null);
    }
}
