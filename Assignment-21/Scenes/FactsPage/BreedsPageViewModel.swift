//
//  BreedsPageViewModel.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 21.11.23.
//

import Foundation
import GenericNetworkManager

protocol BreedsPageViewModelDelegate: AnyObject {
    func breedsFetched(_ breeds: [Breed])
    func showError(_ error: Error)
}

final class BreedsPageViewModel {
    // MARK: - Properties
    private var breedModel: [Breed]?
    weak var delegate: BreedsPageViewModelDelegate?
    let networkManager = GenericNetworkManager(baseURL: Constants.baseURL)
    
    // MARK: - ViewModelLifeCycle
    func viewDidLoad() {
        fetchCatBreeds(limit: 100)
    }
    
    // MARK: - Methods
    private func fetchCatBreeds(limit: Int) {
        networkManager.fetchFacts(endpoint: Constants.breedsEndpointWithLimits + "\(limit)") { [weak self] (result: Result<CatBreedsResponse, Error>) in
            switch result {
            case .success(let breeds):
                self?.breedModel = breeds.data
                self?.delegate?.breedsFetched(breeds.data)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

