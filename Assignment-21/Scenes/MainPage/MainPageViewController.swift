//
//  MainPageViewController.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 19.11.23.
//

import UIKit

class MainPageViewController: UIViewController {
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var facts = [Fact]()
    private let viewModel = MainPageViewModel()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBar()
        setupTableView()
        
        setupViewModelDelegate()
        viewModel.viewDidLoad()
    }
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Random Cat Facts 🐈"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(MainPageTableViewCell.self, forCellReuseIdentifier: MainPageTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupViewModelDelegate() {
        viewModel.delegate = self
    }
}

// MARK: - TableVIew DataSource
extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        facts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.identifier) as? MainPageTableViewCell else {
            return UITableViewCell()
        }
        print(facts)
        cell.configure(with: facts[indexPath.row])
        return cell
    }
}

// MARK: - MainPageViewModelDelegate
extension MainPageViewController: MainPageViewModelDelegate {
    func factsFetched(_ facts: [Fact]) {
        self.facts = facts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}

