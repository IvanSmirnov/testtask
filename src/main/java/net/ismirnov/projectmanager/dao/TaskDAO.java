package net.ismirnov.projectmanager.dao;

import java.util.List;

import net.ismirnov.projectmanager.model.Task;
import net.ismirnov.projectmanager.model.User;

public interface TaskDAO {
	public void addTask(Task task);
	public List<Task> listTasks();
	public void removeTask(Integer id);
	public void updateTask(Task project);
	public List<Task> listTaskByProject(Integer projectId);	
	public List<Task> listTaskByUser(Integer userId);
	public void removeTaskByUserId(Integer id);
	public void removeTaskByProjectId(Integer id);
}
