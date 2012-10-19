package net.ismirnov.projectmanager.model;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.OneToMany;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.CascadeType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Transient;
import javax.persistence.FetchType;

@Entity
@Table(name="users")
public class User{
	
	public User(){
	}

	@Id
	@Column(name="id")
        @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="user_id_seq")
        @SequenceGenerator(name="user_id_seq", sequenceName="user_id_seq", allocationSize=1)
	private Integer id;
	
	@Column(name="login")
	private String login;
	
	@Column(name="password")
	private String password;
	
	@Column(name="first_name")
	private String first_name;

	@Column(name="second_name")
	private String second_name;
	
    @OneToMany(mappedBy="user", fetch = FetchType.EAGER)
    private List<Task> tasks;
    
    public void addTask(Task task){
    	task.setUser(this);
    	tasks.add(task);
    }
	
	public List<Task> getTasks() {
		return tasks;
	}

	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getSecond_name() {
		return second_name;
	}

	public void setSecond_name(String second_name) {
		this.second_name = second_name;
	}
 
}
