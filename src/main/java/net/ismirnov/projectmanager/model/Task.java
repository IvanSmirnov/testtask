package net.ismirnov.projectmanager.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;

@Entity
@Table(name="Tasks")
public class Task {
	@Id
	@Column(name="id")
        @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="users_projects_id_seq")
        @SequenceGenerator(name="users_projects_id_seq", sequenceName="users_projects_id_seq", allocationSize=1)
	private Integer id;
	
	@Column(name="user_id")
	private Integer user_id;
	
	@Column(name="project_id")
	private Integer project_id;
	
	@Column(name="date_begin")
	private Date date_begin;
	
	@Column(name="date_finish")
	private Date date_finish;

	@ManyToOne
	@JoinColumn(name="user_id", insertable=false, updatable=false, nullable=false)
	private User user;
    
	@ManyToOne
	@JoinColumn(name="project_id", insertable=false, updatable=false, nullable=false)
	private Project project;

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getProject_id() {
		return project_id;
	}

	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}

	public Date getDate_begin() {
		return date_begin;
	}

	public void setDate_begin(Date date_begin) {
		this.date_begin = date_begin;
	}

	public Date getDate_finish() {
		return date_finish;
	}

	public void setDate_finish(Date date_finish) {
		this.date_finish = date_finish;
	}
}
