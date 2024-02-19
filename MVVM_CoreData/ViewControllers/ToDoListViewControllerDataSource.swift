//
//  ToDoListViewControllerDataSource.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 19.01.2024.
//

import UIKit


extension ToDoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()

        if section != 0 {
            headerView.backgroundColor = UIColor.lightGray
            let titleLabel = UILabel(frame: CGRect(x: 15, y: 5, width: 200, height: 30))
            titleLabel.text = section == 1 ? "Completed tasks" : "Uncompleted"
            headerView.addSubview(titleLabel)
        }
        return headerView
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40 // устанавливает высоту заголовка
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Конец секции \(section)" // возвращает текст для подвала каждой секции
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20 // устанавливает высоту подвала
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfRowrs(by: section))
        return viewModel.numberOfRowrs(by: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryTableViewCell else { return UITableViewCell() }
            let taskSummary = viewModel.getTasksByType()
            cell.configure(comleted: taskSummary.complete.description,
                           incompleted: taskSummary.incomplete.description)
            return cell
        } else if indexPath.section == 1 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            let task = viewModel.tasks.filter { $0.copmleted }[indexPath.row]
            cell.configure(with: task)
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            let task = viewModel.tasks.filter { !$0.copmleted }[indexPath.row]
            //let task = viewModel.task(by: indexPath.row)
            cell.configure(with: task)
            return cell
        }
    }
}
