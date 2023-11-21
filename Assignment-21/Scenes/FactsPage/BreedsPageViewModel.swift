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
    private var breedModel = [Breed]()
    
    var breeds: [Breed] {
        return breedModel
    }
    
    weak var delegate: BreedsPageViewModelDelegate?
    let networkManager = GenericNetworkManager(baseURL: "https://catfact.ninja/")
    
    // MARK: - Init
    init(breedModel: [Breed] = [Breed]()) {
        self.breedModel = breedModel
    }
    // MARK: - ViewModelLifeCycle
    func viewDidLoad() {
        fetchCatBreeds(limit: 100)
    }
    
    // MARK: - Methods
    private func fetchCatBreeds(limit: Int) {
        networkManager.fetchFacts(endpoint: "breeds?limit=\(limit)") { [weak self] (result: Result<CatBreedsResponse, Error>) in
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

