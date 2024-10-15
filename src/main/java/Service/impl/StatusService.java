package Service.impl;

import Bean.Role;
import Bean.Status;
import Dao.IStatusDao;
import Dao.impl.StatusDao;
import Service.IStatusService;

import java.util.List;

public class StatusService implements IStatusService {
    private IStatusDao iStatusDao = new StatusDao();

    @Override
    public List<Status> selAll() {
        return iStatusDao.selAll();
    }
}
