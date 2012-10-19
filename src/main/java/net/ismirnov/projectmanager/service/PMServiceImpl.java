package net.ismirnov.projectmanager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.ismirnov.projectmanager.dao.UserDAO;
import net.ismirnov.projectmanager.dao.ProjectDAO;
import net.ismirnov.projectmanager.dao.TaskDAO;
import net.ismirnov.projectmanager.form.User;
import net.ismirnov.projectmanager.form.Project;
import net.ismirnov.projectmanager.form.Task;

@Service
public class PMServiceImpl implements PMService {

	@Autowired
	private UserDAO userDAO;
	@Autowired
	private ProjectDAO projectDAO;
	@Autowired
	private TaskDAO taskDAO;
	
	@Transactional
	public void addUser(User user) {
		userDAO.addUser(user);
	}
	
	@Transactional
	public void updateUser(User user) {
		userDAO.updateUser(user);
	}

	@Transactional
	public List<User> listUsers() {
		return userDAO.listUsers();
	}

	@Transactional
	public void removeUser(Integer id) {
		taskDAO.removeTaskByUserId(id);
		userDAO.removeUser(id);
	}
	//----------------------------------------------------

	@Transactional
	public void addProject(Project project) {
		projectDAO.addProject(project);
	}
	
	@Transactional
	public void updateProject(Project user) {
		projectDAO.updateProject(user);
	}

	@Transactional
	public List<Project> listProjects() {
		return projectDAO.listProjects();
	}

	@Transactional
	public void removeProject(Integer id) {
		taskDAO.removeTaskByProjectId(id);
		projectDAO.removeProject(id);
	}

	//----------------------------------------------------

	@Transactional
	public void addTask(Task task) {
		taskDAO.addTask(task);
	}
	
	@Transactional
	public void updateTask(Task task) {
		taskDAO.updateTask(task);
	}

	@Transactional
	public List<Task> listTasks() {
		return taskDAO.listTasks();
	}

	@Transactional
	public void removeTask(Integer id) {
		taskDAO.removeTask(id);
	}
	
	@Transactional
	public List<Task> listTaskByProjectId(Integer id) {
		return taskDAO.listTaskByProject(id);
	}
	
	@Transactional
	public List<Task> listTaskByUserId(Integer id) {
		return taskDAO.listTaskByUser(id);
	}
	
	@Transactional
	public List<User> listUsersNotInProject(Integer id){
		return userDAO.listUsersNotInProject(id);
	}
}
