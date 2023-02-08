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
    
    init(title: String, overview: String, releaseDate: String, posterImagePath: String?) {
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterImagePath = posterImagePath
    }
    
     init(movie: Movie) {
         self.title = movie.title ?? ""
         self.posterImagePath = movie.posterPath
         self.overview = movie.overview ?? ""
         if let releaseDate = movie.releaseDate {
             self.releaseDate = "\(NSLocalizedString("Release Date", comment: "")): \(dateFormatter.string(from: releaseDate))"
         } else {
             self.releaseDate = NSLocalizedString("To be announced", comment: "")
         }
     }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
