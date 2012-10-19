package net.ismirnov.projectmanager.dao;

import java.util.List;
import net.ismirnov.projectmanager.model.User;

public interface UserDAO {
	public void addUser(User user);
	public List<User> listUsers();
	public void removeUser(Integer id);
	public void updateUser(User user);
	public List<User> listUsersNotInProject(Integer id);
}
