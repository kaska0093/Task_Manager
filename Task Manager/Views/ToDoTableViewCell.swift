//
//  ToDoTableViewCell.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .black)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var dueOrCompetedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var competedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        selectionStyle = .none
        [taskNameLabel, dueOrCompetedLabel, competedLabel].forEach { subView in
            contentView.addSubview(subView)
        }
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            taskNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dueOrCompetedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            dueOrCompetedLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor),
            dueOrCompetedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            competedLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 16),
            competedLabel.trailingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor),
            competedLabel.bottomAnchor.constraint(equalTo: dueOrCompetedLabel.bottomAnchor),
            
            //чтобы весь контент ячейки помещался в нее
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: taskNameLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with task: TaskViewModel) {
        let attributedString = NSMutableAttributedString(string: task.name)
        
        if task.copmleted {
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.double.rawValue, range: NSMakeRange(0, attributedString.length))
            taskNameLabel.font = UIFont.italicSystemFont(ofSize: 16)
        } else {
            taskNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        taskNameLabel.attributedText = attributedString
        
        dueOrCompetedLabel.text = task.copmleted ? "Completed on: \(task.copmletedOn.formatted(date: .abbreviated, time: .omitted))" : "Due on: \(task.dueOn.formatted(date: .abbreviated, time: .omitted))"
        
        competedLabel.text = task.copmleted ? "Completed" : "Not Completed"
        competedLabel.textColor = task.copmleted ? .green : .red
    }
}
