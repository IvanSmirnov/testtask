package net.ismirnov.projectmanager.dao;

import java.util.List;

import net.ismirnov.projectmanager.form.Project;
import net.ismirnov.projectmanager.form.User;
import net.ismirnov.projectmanager.form.Task;

public interface UsersProjectsDAO {
	public void addUserProject(Task pair);
	public List<Task> listUsersProjects();
	public void removeUserProject(Integer id);
	public List<Project> listProjectsByUser(User user);
	public List<User> listUsersByProject(Project project);
}
