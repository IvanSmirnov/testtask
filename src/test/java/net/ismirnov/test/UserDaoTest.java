package net.ismirnov.test;

import static org.junit.Assert.*;

import java.util.List;

import net.ismirnov.projectmanager.dao.ProjectDAO;
import net.ismirnov.projectmanager.dao.TaskDAO;
import net.ismirnov.projectmanager.dao.UserDAO;
import net.ismirnov.projectmanager.model.Project;
import net.ismirnov.projectmanager.model.Task;
import net.ismirnov.projectmanager.model.User;

import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.support.DirtiesContextTestExecutionListener;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;
import org.junit.Test;
import junit.framework.Assert;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:/WEB-INF/spring-servlet.xml"})
@TestExecutionListeners({
    DependencyInjectionTestExecutionListener.class,
    DirtiesContextTestExecutionListener.class,
    TransactionalTestExecutionListener.class})
public class UserDaoTest {
	public static final String first_name = new String("Ivan");
	public static final String second_name = new String("Smirnov");
	public static final String login = new String("login");
	public static final String password = new String("password");

	public static User createUser(){
		User user = new User();
	    	user.setFirst_name( first_name );
	    	user.setLogin( login );
	    	user.setPassword(password);
	    	user.setSecond_name(second_name);
		return user;
	}

    @Autowired
    UserDAO user_dao;
    @Autowired
    TaskDAO task_dao;
    @Autowired
    ProjectDAO project_dao;

    @Test  
    public void testUserDao() throws Exception {
    	assertNotNull(user_dao);
    }
  
    @Test
    @Transactional
    public void testAddUser()  throws Exception {
    	User user = createUser();
    	user_dao.addUser(user);
    	List<User> saved_users_list = user_dao.listUsers();
    	assertNotNull(saved_users_list);
    	assertTrue( saved_users_list.size() == 1 );
    	User saved_user = saved_users_list.get(0);
    	assertNotNull( saved_user );
    	assertEquals( saved_user.getFirst_name(), first_name );
    	assertEquals( saved_user.getSecond_name(), second_name );
    	assertEquals( saved_user.getPassword(), password );
    	assertEquals( saved_user.getLogin(), login );
    }
    
    @Test
    @Transactional
    public void testUpdateUser()  throws Exception {
    	User user = createUser();
    	user_dao.addUser(user);
    	user.setLogin("updated login");
    	user_dao.updateUser(user);
    	List<User> saved_users_list = user_dao.listUsers();
    	User updated_user = saved_users_list.get(0);
    	assertNotNull( updated_user );
    	assertEquals( updated_user.getLogin(), "updated login" );
    }
    
    @Test
    @Transactional
    public void testRemoveUser()  throws Exception {
    	List<User> saved_users_list;
    	User user = createUser();
    	user_dao.addUser(user);
    	saved_users_list = user_dao.listUsers();
    	User saved_user = saved_users_list.get(0);
    	user_dao.removeUser( saved_user.getId() );
    	saved_users_list = user_dao.listUsers();
    	assertNotNull( saved_users_list );
    	assertEquals( saved_users_list.size(), 0 );
    }

    
    @Test
    @Transactional
    public void testUsersNotInProject()  throws Exception {
    	User user1 = createUser();
    	User user2 = createUser();
    	User user3 = createUser();
    	List<User> saved_users_list;
    	user3.setLogin("third user");
    	user_dao.addUser(user1);
    	user_dao.addUser(user2);
    	user_dao.addUser(user3);
    	
    	Project project = ProjectDaoTest.createProject();
    	project_dao.addProject(project);
    	Project saved_project = project_dao.listProjects().get(0);
    	saved_users_list = user_dao.listUsers();
    	
    	Task task1 = new Task();
    	task1.setUser_id( saved_users_list.get(0).getId() );
    	task1.setProject_id( saved_project.getId() );
    	task_dao.addTask(task1);
    	
    	Task task2 = new Task();
    	task2.setUser_id( saved_users_list.get(1).getId() );
    	task2.setProject_id( saved_project.getId() );
    	task_dao.addTask(task2);
    	
    	saved_users_list = user_dao.listUsersNotInProject( saved_project.getId() );
    	assertEquals( saved_users_list.size(), 1);
    	assertEquals( saved_users_list.get(0).getLogin(), "third user" );
    }
}
