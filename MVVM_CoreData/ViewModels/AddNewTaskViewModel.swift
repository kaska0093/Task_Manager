//
//  AddNewTaskViewModel.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(nameOfTask: String, dueOn: Date) {
        // call core data and add new record for task
        CoreDataManager.shared.addNewTask(name: nameOfTask, dueOn: dueOn)
    }
}
