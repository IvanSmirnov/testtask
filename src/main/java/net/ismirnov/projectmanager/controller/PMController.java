package net.ismirnov.projectmanager.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.ismirnov.projectmanager.model.Project;
import net.ismirnov.projectmanager.model.Task;
import net.ismirnov.projectmanager.model.User;
import net.ismirnov.projectmanager.service.PMService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PMController {

	@Autowired
	private PMService pmService;

	@RequestMapping("/index")
	public String redirect(Map<String, Object> map) {
		map.put("userList", pmService.listUsers());
		return "redirect:/listusers";
	}
	
	@RequestMapping("/listusers")
	public String listUsers(Map<String, Object> map) {
		map.put("userList", pmService.listUsers());
		return "/admin/users";
	}
	
	@RequestMapping(value = "/updateuser", method = RequestMethod.POST)
	public @ResponseBody String updateUser(@ModelAttribute("user") User user, BindingResult result ) {
		pmService.updateUser(user);
		return user.getId().toString();
	}

	@RequestMapping(value = "/adduser", method = RequestMethod.POST)
	public String addUser(@ModelAttribute("user") User user, BindingResult result) {
		pmService.addUser(user);
		return "redirect:/listusers";
	}
	
	@RequestMapping("/deleteuser/{userId}")
	public String deleteUser(@PathVariable("userId")
	Integer userId) {
		pmService.removeUser(userId);
		return "redirect:/listusers";
	}

	@RequestMapping("/listprojects")
	public String listProjects(Map<String, Object> map) {
		map.put("projectList", pmService.listProjects());
		return "/admin/projects";
	}
	
	@RequestMapping(value = "/updateproject", method = RequestMethod.POST)
	public @ResponseBody String updateUser(@ModelAttribute("project") Project project, 
						BindingResult result ) {
		pmService.updateProject(project);
		return project.getId().toString();
	}

	@RequestMapping(value = "/addproject", method = RequestMethod.POST)
	public String addProject(@ModelAttribute("project") Project project, BindingResult result) {
		pmService.addProject(project);
		return "redirect:/listprojects";
	}
	
	@RequestMapping("/deleteproject/{projectId}")
	public String deleteProject(@PathVariable("projectId") Integer projectId) {
		pmService.removeProject(projectId);
		return "redirect:/listprojects";
	}
	
	@RequestMapping("/tasks")
	public String tasksPage(Map<String, Object> map) {
		map.put("projectList", pmService.listProjects());
		return "/admin/tasks";
	}
	
	@RequestMapping("/listtasksbyproject/{projectId}")
	public ModelAndView listUsersTasks(@PathVariable("projectId") Integer projectId) {
		List<User> users = pmService.listUsersNotInProject( projectId );
		List<Task> tasks = pmService.listTaskByProjectId( projectId );
		
		ModelAndView mvc = new ModelAndView("/admin/user_table");
		mvc.addObject("userList", users);
		mvc.addObject("taskList", tasks);
		return mvc;
	}
	
	@RequestMapping(value = "/addtask", method = RequestMethod.POST)
	public @ResponseBody String addTask(@ModelAttribute("task") Task task, BindingResult result) {
		pmService.addTask(task);
		return Integer.toString( task.getId() );
	}
	
	@RequestMapping(value = "/removetask/{taskId}")
	public @ResponseBody String removeTask(@PathVariable("taskId") Integer taskId) {
		pmService.removeTask(taskId);
		return Integer.toString( taskId );
	}
	
	@RequestMapping("/userpage")
	public String userMainPage(Map<String, Object> map) {
		map.put("userList", pmService.listUsers());
		return "/user_page";
	}
	
	@RequestMapping("/listtasksbyuser/{userId}")
	public ModelAndView listTasksByUser(@PathVariable("userId") Integer userId) {
		List<Task> tasks = pmService.listTaskByUserId( userId );
		ModelAndView mvc = new ModelAndView("/task_table");
		mvc.addObject("taskList", tasks);
		return mvc;
	}
	
}
