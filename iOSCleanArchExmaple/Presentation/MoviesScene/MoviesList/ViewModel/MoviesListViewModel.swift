//
//  MoviesListViewModel.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation
import SwiftUI

struct MoviesListViewModelActions {
    
}

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

final class MoviesListViewModel: ObservableObject {
    private let searchMoviesUseCase: SearchMoviesUseCase?
    private let actions: MoviesListViewModelActions?
    
    init(searchMoviesUseCase: SearchMoviesUseCase?, actions: MoviesListViewModelActions?) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }
    
    private convenience init() {
        self.init(searchMoviesUseCase: nil, actions: nil)
    }
    
    @Published var items: [MoviesListItemViewModel] = []
    @Published var loading: MoviesListViewModelLoading? = nil
    
    func requestSearch(query: String) {
        
    }
    
}

extension MoviesListViewModel {
    // MARK: - Test
    static func createDummy() -> MoviesListViewModel {
        let dummy = MoviesListViewModel()
        dummy.items = .init(repeating: .createDummy(), count: 5)
        return dummy
    }
}
