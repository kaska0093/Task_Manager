//
//  CoreDataManager.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import CoreData
import Foundation

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistantContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistantContainer.viewContext
    }
    
    func saveContext() {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func getAll() -> [Task] {
        var tasks = [Task]()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return tasks
    }
    
    func addNewTask(name: String, dueOn: Date) {
        let task = Task(context: context)
        task.name = name
        task.dueOn = dueOn
        task.id = UUID()
        task.isDone = false
        task.copletedOn = dueOn.advanced(by: 100000)
        task.isFavourite = false //---------------------------------
        saveContext()
    }
    
    func toogleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            let fetchTasks = try context.fetch(fetchRequest)
            for task in fetchTasks {
                task.isDone = !task.isDone
                if task.isDone {
                    task.copletedOn = Date()
                }
            }
            saveContext()
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        do {
            let fetchTasks = try context.fetch(fetchRequest)
            for task in fetchTasks {
                context.delete(task)
            }
            saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
