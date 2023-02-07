//
//  MoviesRequestDTO+Mapping.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
