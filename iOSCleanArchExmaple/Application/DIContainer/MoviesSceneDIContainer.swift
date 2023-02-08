//
//  MoviesSceneDIContainer.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation
import UIKit
import SwiftUI

final class MoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

//    // MARK: - Persistent Storage
    lazy var moviesQueriesStorage: MoviesQueriesStorage = CoreDataMoviesQueriesStorage(maxStorageLimit: 10)
    lazy var moviesResponseCache: MoviesResponseStorage = CoreDataMoviesResponseStorage()
//
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
//
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        return DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository(),
                                          moviesQueriesRepository: makeMoviesQueriesRepository())
    }
//
//    func makeFetchRecentMovieQueriesUseCase(requestValue: FetchRecentMovieQueriesUseCase.RequestValue,
//                                            completion: @escaping (FetchRecentMovieQueriesUseCase.ResultValue) -> Void) -> UseCase {
//        return FetchRecentMovieQueriesUseCase(requestValue: requestValue,
//                                              completion: completion,
//                                              moviesQueriesRepository: makeMoviesQueriesRepository()
//        )
//    }
//
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        return DefaultMoviesRepository(dataTransferService: dependencies.apiDataTransferService, cache: moviesResponseCache)
    }
    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
        return DefaultMoviesQueriesRepository(dataTransferService: dependencies.apiDataTransferService,
                                              moviesQueriesPersistentStorage: moviesQueriesStorage)
    }
    func makePosterImagesRepository() -> PosterImagesRepository {
        return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService)
    }

    // MARK: - Movies List ViewModel

    func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
        return MoviesListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase(),
                                   actions: actions)
    }
//
//    // MARK: - Movie Details
    func makeMoviesDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movie: movie, posterImagesRepository: makePosterImagesRepository())
    }
//
//    // MARK: - Movies Queries Suggestions List
//    func makeMoviesQueriesSuggestionsListViewController(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> UIViewController {
//        if #available(iOS 13.0, *) { // SwiftUI
//            let view = MoviesQueryListView(viewModelWrapper: makeMoviesQueryListViewModelWrapper(didSelect: didSelect))
//            return UIHostingController(rootView: view)
//        } else { // UIKit
//            return MoviesQueriesTableViewController.create(with: makeMoviesQueryListViewModel(didSelect: didSelect))
//        }
//    }
//
//    func makeMoviesQueryListViewModel(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> MoviesQueryListViewModel {
//        return DefaultMoviesQueryListViewModel(numberOfQueriesToShow: 10,
//                                               fetchRecentMovieQueriesUseCaseFactory: makeFetchRecentMovieQueriesUseCase,
//                                               didSelect: didSelect)
//    }
//
//    @available(iOS 13.0, *)
//    func makeMoviesQueryListViewModelWrapper(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> MoviesQueryListViewModelWrapper {
//        return MoviesQueryListViewModelWrapper(viewModel: makeMoviesQueryListViewModel(didSelect: didSelect))
//    }
//
//    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        return MoviesSearchFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    // Movies List
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> UIViewController {
        let newView = MoviesListView(moviesListViewModel: makeMoviesListViewModel(actions: actions))
        return UIHostingController(rootView: newView)
//        return MoviesListViewController.create(with: makeMoviesListViewModel(actions: actions), posterImagesRepository: makePosterImagesRepository())
    }
    
    
    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController {
        let newView = MovieDetailsView(movieDetailViewModel: makeMoviesDetailsViewModel(movie: movie))
        return UIHostingController(rootView: newView)
    }
    //    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController {
    //        return MovieDetailsViewController.create(with: makeMoviesDetailsViewModel(movie: movie))
    //    }
}
