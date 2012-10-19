package net.ismirnov.projectmanager.dao;

import java.util.List;

import net.ismirnov.projectmanager.form.Project;
import net.ismirnov.projectmanager.form.User;

public interface ProjectDAO {
	public void addProject(Project project);
	public List<Project> listProjects();
	public void removeProject(Integer id);
	public int updateProject(Project project);
//	public List<Project> listProjectsByUser(User user);
//	public List<User> listUsersByProject(Project project);
}
