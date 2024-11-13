package com.shivesh.taskMan.controller;

import org.springframework.web.bind.annotation.RestController;

import com.shivesh.taskMan.model.Task;
import com.shivesh.taskMan.service.TaskService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;



@RestController
@CrossOrigin(origins = "http://localhost:52758")
public class TaskController {

	@Autowired
	private TaskService taskService;
	
	@GetMapping("/tasks")
	public ResponseEntity<List<Task>> getTasks() {
		List<Task> tasks = taskService.getTasks();
		
		if (tasks.isEmpty()) {
            return ResponseEntity.noContent().build(); // 204 No Content if no tasks found
        }
        return ResponseEntity.ok(tasks);
	}
	
	@GetMapping("/tasks/{id}")
	public ResponseEntity<Task> getTask(@PathVariable Long id) {
		Task task = taskService.getTask(id);
		
		if (task==null) {
            return ResponseEntity.noContent().build(); // 204 No Content if no tasks found
        }
        return ResponseEntity.ok(task);
	}
	
	@PostMapping("/task")
	public ResponseEntity<Task> createTask(@RequestBody Task task) {
		//TODO: process POST request
		
		Task taskCreated = taskService.createTask(task);
		return new ResponseEntity<>(taskCreated,HttpStatus.CREATED);
		
	}
	
	@PutMapping("/task/{id}")
	public ResponseEntity<Task> updateTask(@RequestBody Task task,@PathVariable Long id) {
		//TODO: process POST request
		
		Task taskCreated = taskService.updateTask(task,id);
		return new ResponseEntity<>(taskCreated,HttpStatus.CREATED);
		
	}
	
	@DeleteMapping("/task/{id}")
	public ResponseEntity<String> deleteTask(@PathVariable Long id) {
		//TODO: process POST request
		
		taskService.deleteTask(id);
		return new ResponseEntity<String>("Deleted Successfully",HttpStatus.OK);
		
	}
	
	
}
