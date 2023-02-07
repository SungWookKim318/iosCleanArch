//
//  MoviesListItemViewModel.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation

struct MoviesListItemViewModel: Equatable, Hashable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
    
    static func createDummy() -> MoviesListItemViewModel {
        return MoviesListItemViewModel(title: "Test Title", overview: "OverView OverView", releaseDate: "2019-09-08", posterImagePath: nil)
    }
}
