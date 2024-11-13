package com.shivesh.taskMan.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shivesh.taskMan.model.Task;

public interface TaskRepo extends JpaRepository<Task, Long> {

}
