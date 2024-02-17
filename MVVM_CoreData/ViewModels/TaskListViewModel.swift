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
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func getAll() {
        tasks = CoreDataManager.shared.getAll().map(TaskViewModel.init)
        //преобразование в массив TaskViewModel
    }
    
    func numberOfRowrs(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return numberOfTasks
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
    
    func task(by index: Int) -> TaskViewModel {
        tasks[index]
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
