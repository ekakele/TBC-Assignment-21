//
//  BreedsPageViewController.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 21.11.23.
//

import UIKit

class BreedsPageViewController: UIViewController {
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var breeds = [Breed]()
    private let viewModel = BreedsPageViewModel()
    
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
        self.navigationItem.title = "Cat Breeds 🐈‍⬛"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(BreedsPageTableViewCell.self, forCellReuseIdentifier: BreedsPageTableViewCell.identifier)
        
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
extension BreedsPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BreedsPageTableViewCell.identifier) as? BreedsPageTableViewCell else {
            return UITableViewCell()
        }
        print(breeds)
        cell.configure(with: breeds[indexPath.row])
        return cell
    }
}

// MARK: - MainPageViewModelDelegate
extension BreedsPageViewController: BreedsPageViewModelDelegate {
    func breedsFetched(_ breeds: [Breed]) {
        self.breeds = breeds
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        print(error.localizedDescription)
    }
}

