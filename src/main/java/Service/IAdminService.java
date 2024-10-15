package Service;

import Bean.Admin;
import Bean.Role;
import Bean.UserQuery;
import Util.PageTable;

import java.util.List;

public interface IAdminService {
    Admin loginAdmin(Admin admin);
    Admin selAll(String id);
    Boolean add(String id);
    PageTable selPage(UserQuery userQuery);
    Boolean del(String id);
    Boolean delAll(String[] ids);
    Boolean isStop(Integer id, String isStop);
}

