//
//  Breed.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 21.11.23.
//

import Foundation

struct CatBreedsResponse: Decodable {
    let data: [Breed]
}

struct Breed: Decodable {
    let breed: String
}
