package com.shivesh.taskMan.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shivesh.taskMan.model.Task;
import com.shivesh.taskMan.repo.TaskRepo;

import jakarta.annotation.Nullable;

@Service
public class TaskService {

	@Autowired
	private TaskRepo taskRepo;
	
	public List<Task> getTasks(){
		return taskRepo.findAll();
	}
	
	public Task createTask(Task task) {
		Task taskCreated = taskRepo.save(task);
		return taskCreated;
	}
	public Task getTask(Long id) {
		Optional<Task> task = taskRepo.findById(id);
		
		if(task.isEmpty()) {
			return null;
		}
		return task.get();
	}
	
	public Task updateTask(Task task,Long id) {
		
		System.out.println(task);
		System.out.println("IN UPDATE");
		Task old = getTask(id);
		old.setCompleted(task.getCompleted());
		old.setDescr(task.getDescr());
		old.setDueDate(task.getDueDate());
		old.setPriority(task.getPriority());
		old.setTitle(task.getTitle());
		System.out.println(old);
		
		Task taskCreated = taskRepo.save(old);
		return taskCreated;
	}
	
	public void deleteTask(Long id) {
		Task task = getTask(id);
		if(task==null)throw new RuntimeException("No such Task");
        taskRepo.deleteById(id);
    }
}
