package net.ismirnov.projectmanager.service;

import java.util.List;

import net.ismirnov.projectmanager.model.Project;
import net.ismirnov.projectmanager.model.Task;
import net.ismirnov.projectmanager.model.User;

public interface PMService {
	
	public void addUser(User contact);
	public List<User> listUsers();
	public void removeUser(Integer id);
	public void updateUser(User contact);
	
	public void addProject(Project project);
	public List<Project> listProjects();
	public void removeProject(Integer id);
	public void updateProject(Project contact);
	
	public void addTask(Task project);
	public List<Task> listTasks();
	public void removeTask(Integer id);
	public void updateTask(Task task);
	public List<Task> listTaskByProjectId(Integer id);
	public List<Task> listTaskByUserId(Integer id);
	public List<User> listUsersNotInProject(Integer id);
}
