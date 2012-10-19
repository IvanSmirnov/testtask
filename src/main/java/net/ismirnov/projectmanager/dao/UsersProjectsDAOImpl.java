package net.ismirnov.projectmanager.dao;
import java.util.List;

import net.ismirnov.projectmanager.form.Project;
import net.ismirnov.projectmanager.form.User;
import net.ismirnov.projectmanager.form.Task;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsersProjectsDAOImpl implements UsersProjectsDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	public void addUserProject(Task pair) {
		sessionFactory.getCurrentSession().save(pair);	
	}

	public List<Task> listUsersProjects() {
		return sessionFactory.getCurrentSession().createQuery("from UsersProjects").list();
	}

	public void removeUserProject(Integer id) {
		Task pair = (Task) sessionFactory.getCurrentSession().load( Task.class, id );
		if (null != pair) {
			sessionFactory.getCurrentSession().delete(pair);
		}
	}

	public List<Project> listProjectsByUser(User user) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<User> listUsersByProject(Project project) {
		// TODO Auto-generated method stub
		return null;
	}

}
