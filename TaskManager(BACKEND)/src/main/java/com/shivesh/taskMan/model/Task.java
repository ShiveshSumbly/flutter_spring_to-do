package com.shivesh.taskMan.model;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import com.shivesh.taskMan.util.com.shivesh.taskMan.util.enums.Priority;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Task {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String title;
	private String descr;
	private boolean completed;
	
	private Priority priority;
	@CreationTimestamp
	private LocalDateTime createdDate;
	private LocalDateTime dueDate;
	public Long getId() {
		return id;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public boolean isCompleted() {
		return completed;
	}
	public void setCompleted(boolean completed) {
		this.completed = completed;
	}
	public boolean getCompleted() {
		return completed;
	}
	public Priority getPriority() {
		return priority;
	}
	public void setPriority(Priority priority) {
		this.priority = priority;
	}
	public LocalDateTime getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	@Override
	public String toString() {
		return "Task [id=" + id + ", title=" + title + ", descr=" + descr + ", completed=" + completed + ", priority="
				+ priority.toString() + ", createdDate=" + createdDate + ", dueDate=" + dueDate + "]";
	}

	public LocalDateTime getDueDate() {
		return dueDate;
	}

	public void setDueDate(LocalDateTime dueDate) {
		this.dueDate = dueDate;
	}
	
	
	
	

}
