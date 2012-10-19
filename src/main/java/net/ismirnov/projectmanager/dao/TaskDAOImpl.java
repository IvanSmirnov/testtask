package net.ismirnov.projectmanager.dao;

import java.util.List;
import java.util.Date;
import net.ismirnov.projectmanager.model.Task;
import net.ismirnov.projectmanager.model.User;
import net.ismirnov.projectmanager.dao.TaskDAO;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TaskDAOImpl implements TaskDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	public void addTask(Task task) {
		sessionFactory.getCurrentSession().save(task);		
	}

	public List<Task> listTasks() {
		return sessionFactory.getCurrentSession().createQuery("from Task").list();
	}

	public void removeTask(Integer id) {
		Task task = (Task) sessionFactory.getCurrentSession().load( Task.class, id );
		if (null != task) {
			sessionFactory.getCurrentSession().delete(task);
		}
	}

	public void updateTask(Task task) {
		sessionFactory.getCurrentSession().update( task );
	}
	
	public List<Task> listTaskByProject(Integer projectId){
		return (List<Task>)sessionFactory.getCurrentSession().
			createQuery(" from Task where project_id = :projId ").setInteger("projId", projectId).list();
	}
	
	public List<Task> listTaskByUser(Integer userId){
		return (List<Task>)sessionFactory.getCurrentSession().
		createQuery(" from Task where user_id = :userId and date_begin " +
				"<= :current_date and date_finish >= :current_date")
				.setInteger("userId", userId)
				.setDate("current_date", new Date()).list();
	}
	
	public void removeTaskByUserId(Integer userId){
		sessionFactory.getCurrentSession()
				.createQuery(" delete Task where user_id = :_user_id")
				.setInteger("_user_id", userId)
				.executeUpdate();
	}

	public void removeTaskByProjectId(Integer projectId){
		sessionFactory.getCurrentSession()
				.createQuery(" delete Task where project_id = :_project_id")
				.setInteger("_project_id", projectId)
				.executeUpdate();
	}
}
