package net.ismirnov.projectmanager.dao;

import java.util.List;

import net.ismirnov.projectmanager.form.Task;
import net.ismirnov.projectmanager.form.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public void addUser(User user) {
		sessionFactory.getCurrentSession().save(user);
	}

	public List<User> listUsers() {
		return sessionFactory.getCurrentSession().createQuery("from User ORDER BY id")
				.list();
	}

	public void removeUser(Integer id) {
		User user = (User) sessionFactory.getCurrentSession().load(
				User.class, id);
		if (null != user) {
			sessionFactory.getCurrentSession().delete(user);
		}
	}
	
	public void updateUser(User user){
		sessionFactory.getCurrentSession().update( user );
	}
	
	public List<User> listUsersNotInProject(Integer id){
		return sessionFactory.getCurrentSession()
				.createQuery("select u from User u left join u.tasks t where t.project_id <> :projectId or t.project_id is null")
				.setInteger("projectId", id)
				.list();
	}
}
