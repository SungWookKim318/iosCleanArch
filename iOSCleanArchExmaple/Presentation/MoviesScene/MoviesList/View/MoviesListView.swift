//
//  MoviesListView.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var moviesListViewModel: MoviesListViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                SearchBarView(defaultText: moviesListViewModel.searchBarPlaceholder) { text in
                    moviesListViewModel.requestSearch(queryText: text)
                }
                ZStack {
                    MoviesListTableView(movies: $moviesListViewModel.items) { index in
                        moviesListViewModel.selectMovie(at: index)
                    }
                        .clipped()
                    if moviesListViewModel.loading == .nextPage {
                        loadingView()
                            .clipped()
                    }
                }
            }
            if moviesListViewModel.loading == .fullScreen {
                loadingView()
                    .ignoresSafeArea(.all)
            }
        }
        .navigationBarTitle("", displayMode: .automatic)
        .navigationBarHidden(true)
    }
}

extension MoviesListView {
    @ViewBuilder
    func loadingView() -> some View {
        ProgressView()
            .scaleEffect(2)
            .progressViewStyle(CircularProgressViewStyle(tint: Color.yellow))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.5))
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(moviesListViewModel: .createDummy(itemCount: 10))
        MoviesListView(moviesListViewModel: .createDummy(itemCount: 0))
    }
}
