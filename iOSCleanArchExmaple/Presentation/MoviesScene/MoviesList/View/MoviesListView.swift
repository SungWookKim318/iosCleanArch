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
                SearchBarView { text in
                    
                }
                ZStack {
                    MoviesListTableView(movies: $moviesListViewModel.items)
                        .clipped()
                }
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(moviesListViewModel: .createDummy())
    }
}
