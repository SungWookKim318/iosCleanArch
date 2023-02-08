//
//  MoviesListViewModel.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation
import SwiftUI

// MARK: - MoviesListViewModelActions

struct MoviesListViewModelActions {
    let showMovieDetails: (Movie) -> Void
}

// MARK: - MoviesListViewModelLoading

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

// MARK: - MoviesListViewModel

final class MoviesListViewModel: ObservableObject {
    private let searchMoviesUseCase: SearchMoviesUseCase?
    private let actions: MoviesListViewModelActions?
    private var moviesLoadTask: Cancellable? {
        willSet {
            moviesLoadTask?.cancel()
        }
    }
    
    private var pages: [MoviesPage] = []

    init(searchMoviesUseCase: SearchMoviesUseCase?, actions: MoviesListViewModelActions?) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }

    private convenience init() {
        self.init(searchMoviesUseCase: nil, actions: nil)
    }

    @Published var items: [MoviesListItemViewModel] = []
    @Published var loading: MoviesListViewModelLoading? = nil
    @Published var errorText: String?
    var query: String = ""

    let searchBarPlaceholder = "Search Movies"
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    func requestSearch(queryText: String) {
        guard !queryText.isEmpty else { return }
        self.loading = .fullScreen
        self.query = queryText
        let query = MovieQuery(query: queryText)
        

        moviesLoadTask = searchMoviesUseCase?.execute(requestValue: .init(query: query, page: nextPage), cached: appendPage(_:), completion: { result in
            switch result {
            case .success(let success):
                self.appendPage(success)
            case .failure(let failure):
                self.handle(error: failure)
            }
            self.loading = .none
        })
    }
    
    func selectMovie(at index: Int) {
        actions?.showMovieDetails(pages.movies[index])
    }
}

// MARK: - Test

extension MoviesListViewModel {
    static func createDummy(itemCount: Int) -> MoviesListViewModel {
        let dummy = MoviesListViewModel()
        dummy.items = .init(repeating: .createDummy(), count: itemCount)
        return dummy
    }
}

// MARK: - Helper

extension MoviesListViewModel {
    private func appendPage(_ moviesPage: MoviesPage) {
        currentPage = moviesPage.page
        totalPageCount = moviesPage.totalPages

        pages = pages
            .filter { $0.page != moviesPage.page }
            + [moviesPage]

        DispatchQueue.main.async { [weak self] in
            if let self = self {
                self.items = self.pages.movies.map(MoviesListItemViewModel.init)
            }
        }
    }
    
    private func handle(error: Error) {
        self.errorText = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading movies", comment: "")
    }
}

// MARK: - Private

private extension Array where Element == MoviesPage {
    var movies: [Movie] { flatMap { $0.movies } }
}
