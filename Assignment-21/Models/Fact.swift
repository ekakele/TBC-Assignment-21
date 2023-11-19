//
//  Fact.swift
//  Assignment-21
//
//  Created by Eka Kelenjeridze on 19.11.23.
//

import Foundation

struct CatFactsResponse: Decodable {
    let data: [Fact]
}

struct Fact: Decodable {
    let fact: String
    let length: Int
}
