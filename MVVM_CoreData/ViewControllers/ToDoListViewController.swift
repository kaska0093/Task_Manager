//
//  ViewController.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 17.01.2024.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    let viewModel = TaskListViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        table.register(SummaryTableViewCell.self, forCellReuseIdentifier: "SummaryCell")
        table.estimatedRowHeight = 200
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    lazy var celebrateAnimationView: CelebrationAnimaionView = {
        let v = CelebrationAnimaionView(fileName: "Animation - 1705725296981")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor1
        title = "ToDo"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        view.addSubview(tableView)
        view.addSubview(celebrateAnimationView)
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
//        celebrateAnimationView.play { finished in
//            print("Done playing")
//        }
    }
    
    @objc func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }
  
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            celebrateAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            celebrateAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
            celebrateAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            celebrateAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}





//    lazy var addNewButton: UIButton = {
//       let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("add task", for: .normal)
//        button.addTarget(self, action: #selector(addNEwTask(sender:)), for: .touchUpInside)
//        button.backgroundColor = .gray
//        return button
//    }()
//    lazy var getTasksButton: UIButton = {
//       let button = UIButton()
//        button.backgroundColor = .gray
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("get task", for: .normal)
//        button.addTarget(self, action: #selector(getTask(sender:)), for: .touchUpInside)
//        return button
//    }()
//    lazy var toogleCompletedButton: UIButton = {
//       let button = UIButton()
//        button.backgroundColor = .gray
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("mark task completed", for: .normal)
//        button.addTarget(self, action: #selector(markCompleted(sender:)), for: .touchUpInside)
//        return button
//    }()
//    lazy var deleteTaskButton: UIButton = {
//       let button = UIButton()
//        button.backgroundColor = .gray
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("delete", for: .normal)
//        button.addTarget(self, action: #selector(deleteTask(sender:)), for: .touchUpInside)
//        return button
//    }()


//
//    @objc func addNEwTask(sender: UIButton) {
//        CoreDataManager.shared.addNewTask(name: "new task", dueOn: Date().addingTimeInterval(10000))
//    }
//    @objc func getTask(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            print(task.name ?? "")
//        }
//    }
//    @objc func markCompleted(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.toogleCompleted(id: task.id ?? UUID())
//        }
//        let fetchtasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            print("\(task.name ?? "WW") : \(task.isDone), \(task.copletedOn?.formatted(date: .abbreviated, time: .omitted) ?? "QQ")")
//        }
//    }
//    @objc func deleteTask(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.delete(id: task.id ?? UUID())
//        }
//        let fetchTasks = CoreDataManager.shared.getAll()
//        print(fetchTasks.count)
//        for task in tasks {
//            print("\(task.name ?? "WW") : \(task.isDone), \(task.copletedOn?.formatted(date: .abbreviated, time: .omitted) ?? "QQ")")
//        }
//    }
    
//    func addViews() {
//
//        [addNewButton, getTasksButton, toogleCompletedButton, deleteTaskButton].forEach { control in
//            view.addSubview(control)
//        }
//    }
//
