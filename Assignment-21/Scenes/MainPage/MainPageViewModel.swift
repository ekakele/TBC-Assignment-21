//
//  MainPageViewModel.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 19.11.23.
//

import Foundation
import CatFactsNetworkManager

protocol MainPageViewModelDelegate: AnyObject {
    func factsFetched(_ facts: [Fact])
    func showError(_ error: Error)
}

final class MainPageViewModel {
    // MARK: - Properties
    private var factModel = [Fact]()
    var facts: [Fact] {
        return factModel
    }
    weak var delegate: MainPageViewModelDelegate?
    let networkManager = CatFactsNetworkManager(limit: 100)
    
    // MARK: - Init
    init(factModel: [Fact] = [Fact]()) {
        self.factModel = factModel
    }
    
    // MARK: - ViewModelLifeCycle
    func viewDidLoad() {
        fetchCatFacts()
    }
    
    // MARK: - Methods
    private func fetchCatFacts() {
        networkManager.fetchFacts(limit: 100) { [weak self] (result: Result<CatFactsResponse, Error>) in
            switch result {
            case .success(let facts):
                self?.factModel = facts.data
                self?.delegate?.factsFetched(facts.data)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}
