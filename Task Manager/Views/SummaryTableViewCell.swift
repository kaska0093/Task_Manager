//
//  SummaryTableViewCell.swift
//  MVVM_CoreData
//
//  Created by Nikita Shestakov on 18.01.2024.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = UIStackView.spacingUseSystem
        stack.backgroundColor = UIColor.secondarySystemBackground
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stack.layer.cornerRadius = 20
        stack.clipsToBounds = true
        return stack
    }()
    
    lazy var completedlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var inCompletedlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        selectionStyle = .none
        stackView.addArrangedSubview(inCompletedlabel)
        stackView.addArrangedSubview(completedlabel)
        
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(comleted: String, incompleted: String) {
        completedlabel.text = "✅ Completed \(comleted)"
        inCompletedlabel.text = "❌ TODO \(incompleted)"
    }
}
