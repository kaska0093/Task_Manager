//
//  TaskViewModel.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import Foundation

struct TaskViewModel {
    
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var copmleted: Bool {
        task.isDone
    }
    
    var id: UUID {
        task.id ?? UUID()
    }
    var name: String {
        task.name ?? ""
    }
    
    var dueOn: Date {
        task.dueOn ?? Date()
    }
    
    var copmletedOn: Date {
        task.copletedOn ?? Date()
    }
    

}
