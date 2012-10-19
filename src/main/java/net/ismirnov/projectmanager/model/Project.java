package net.ismirnov.projectmanager.model;

import java.util.List;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.SequenceGenerator;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;

@Entity
@Table(name="projects")
public class Project {
	
	@Id
	@Column(name="id")
        @GeneratedValue(strategy = GenerationType.SEQUENCE, generator="projects_id_seq")
        @SequenceGenerator(name="projects_id_seq", sequenceName="projects_id_seq", allocationSize=1)
	private Integer id;
	
	@Column(name="title")
	private String title;
	
	@OneToMany(mappedBy="project", fetch = FetchType.EAGER)
	private List<Task> tasks;

	public List<Task> getTasks() {
		return tasks;
	}

	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}
	
	public void addTask(Task task){
		task.setProject(this);
		tasks.add(task);
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
