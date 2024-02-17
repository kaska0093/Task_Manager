//
//  ToDoListViewControllerDelegate.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 19.01.2024.
//

import UIKit

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.task(by: indexPath.row)
        
        let completeAction = UIContextualAction(style: .normal, title: task.copmleted ? "Not completed" : "Complete") { [weak self] (action, view, complitionHandler) in
            self?.completetask(at: indexPath)
            complitionHandler(true)
        }
        completeAction.backgroundColor = task.copmleted ? .red : .green
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        // более 50: проведенного свайка считается что кнока нажата
        return configuration
    }
    
    func completetask(at indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        viewModel.toogleCompleted(task: task)
        
        if task.copmleted {
            celebrateAnimationView.isHidden = false
            celebrateAnimationView.play { finished in
                self.celebrateAnimationView.isHidden = finished
            }
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
        // чтоб на первую ячейку не действовали свайпы
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let task = viewModel.task(by: indexPath.row)
        viewModel.deleteItem(task: task)
        tableView.reloadData()
    }
}
