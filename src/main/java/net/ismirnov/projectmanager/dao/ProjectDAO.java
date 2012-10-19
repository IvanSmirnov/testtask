package net.ismirnov.projectmanager.dao;

import java.util.List;

import net.ismirnov.projectmanager.model.Project;
import net.ismirnov.projectmanager.model.User;

public interface ProjectDAO {
	public void addProject(Project project);
	public List<Project> listProjects();
	public void removeProject(Integer id);
	public void updateProject(Project project);
}
