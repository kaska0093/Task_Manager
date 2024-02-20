//
//  TaskListViewModel.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import Foundation

class TaskListViewModel {
    
    var tasks = [TaskViewModel]()
    
    init() {
        getAll()
        print(tasks)
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func getAll() {
        tasks = CoreDataManager.shared.getAll().map(TaskViewModel.init)

        tasks = sortTask(tasks: self.tasks)
    }
    func sortTask(tasks: [TaskViewModel]) -> [TaskViewModel] {
        let sortedTasks = tasks.sorted(by: { (task1, task2) in
            return task1.copmleted && !task2.copmleted
        })
        return sortedTasks
    }
    
    func numberOfRowrs(by section: Int) -> Int {

        if section == 0 {
            return 1
        } else if section == 1 {
            return tasks.filter { $0.copmleted }.count
        } else {
            return tasks.filter { !$0.copmleted }.count
        }
        //return numberOfTasks
    }
    
    func getTasksByType() -> (complete: Int, incomplete: Int) {
        let completedCount = tasks.lazy.filter( { (task: TaskViewModel) -> Bool in
            return task.copmleted
        }).count
        let inCompletedCount = tasks.lazy.filter({task in
            !task.copmleted}).count
        //let inCompletedCount = tasks.lazy.filter({$0.copmleted})
        return (completedCount, inCompletedCount)
    }
    
    func currentTask(by index: Int) -> TaskViewModel {
        print(index)
        print(tasks)
        return tasks[index]
    }
    
    func toogleCompleted(task: TaskViewModel) {
        // call core data to toggle completes state
        CoreDataManager.shared.toogleCompleted(id: task.id)
        getAll()
    }
    
    func deleteItem(task: TaskViewModel) {
        // call core data to deleta the task
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }
}
