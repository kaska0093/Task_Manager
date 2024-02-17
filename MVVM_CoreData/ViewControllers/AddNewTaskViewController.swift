//
//  AddNewTaskViewController.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import UIKit

class AddNewTaskViewController: UIViewController {
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Task Name"
        return label
    }()
    lazy var taskMameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter task name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    lazy var dueOnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Due on"
        return label
    }()
    lazy var dueONDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let viewModel = AddNewTaskViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()

    }
    
    private func setupViews() {
        view.backgroundColor = .backgroundColor1
        title = "Add new Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        [taskNameLabel, taskMameTextField, dueOnLabel, dueONDatePicker].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            taskMameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskMameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taskMameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dueOnLabel.topAnchor.constraint(equalTo: taskMameTextField.bottomAnchor, constant: 20),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskMameTextField.leadingAnchor),
            
            dueONDatePicker.topAnchor.constraint(equalTo: taskMameTextField.bottomAnchor, constant: 8),
            dueONDatePicker.trailingAnchor.constraint(equalTo: taskMameTextField.trailingAnchor)
        ])
        
    }
    
    
    @objc
    func saveTask() {
        guard let taskName = taskMameTextField.text, !taskName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let dueOn = dueONDatePicker.date
        viewModel.addTask(nameOfTask: taskName, dueOn: dueOn)
        navigationController?.popViewController(animated: true)
    }


}
