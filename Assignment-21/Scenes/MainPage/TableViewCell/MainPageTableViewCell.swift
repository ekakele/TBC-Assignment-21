//
//  MainPageTableViewCell.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 19.11.23.
//

import UIKit

final class MainPageTableViewCell: UITableViewCell {
    static let identifier = "FactTableViewCell"
    
    // MARK: - Properties
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let factLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupCellStackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - CellLifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        factLabel.text = nil
    }
    
    // MARK: - Configure
    func configure(with model: Fact) {
        factLabel.text = model.fact
    }
    
    // MARK: - Private Methods
    private func setupCellStackView() {
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(factLabel)
        
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: self.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
