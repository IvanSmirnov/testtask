package net.ismirnov.projectmanager.dao;

import java.util.List;

import net.ismirnov.projectmanager.form.Project;
import net.ismirnov.projectmanager.form.User;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectDAOImpl implements ProjectDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	public void addProject(Project project) {
		sessionFactory.getCurrentSession().save(project);		
	}

	public List<Project> listProjects() {
		return sessionFactory.getCurrentSession().createQuery("from Project").list();
	}

	public void removeProject(Integer id) {
		Project project = (Project) sessionFactory.getCurrentSession().load( Project.class, id );
		if (null != project) {
			sessionFactory.getCurrentSession().delete(project);
		}
	}

	public int updateProject(Project project) {
		sessionFactory.getCurrentSession().update( project );
		return 0;
	}

}
