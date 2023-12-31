//
//  MainPageViewModel.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 19.11.23.
//

import Foundation
import GenericNetworkManager

protocol MainPageViewModelDelegate: AnyObject {
    func factsFetched(_ facts: [Fact])
    func showError(_ error: Error)
}

final class MainPageViewModel {
    // MARK: - Properties
    private var factModel: [Fact]?
    weak var delegate: MainPageViewModelDelegate?
    let networkManager = GenericNetworkManager(baseURL: Constants.baseURL)
    
    // MARK: - ViewModelLifeCycle
    func viewDidLoad() {
        fetchCatFacts(limit: 100)
    }
    
    // MARK: - Methods
    private func fetchCatFacts(limit: Int) {
        networkManager.fetchFacts(endpoint: Constants.factsEndpointWithLimits + "\(limit)") { [weak self] (result: Result<CatFactsResponse, Error>) in
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
