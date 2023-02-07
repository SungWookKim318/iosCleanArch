//
//  MoviesListTableView.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import SwiftUI

struct MoviesListTableView: View {
    @Binding var movies: [MoviesListItemViewModel]
    var body: some View {
        VStack {
            ForEach((0...movies.count-1), id: \.self) { index in
                MoviesListItemView(itemViewModel: movies[index])
            }
        }
    }
}

struct MoviesListTableView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListTableView(movies: .constant(Array<MoviesListItemViewModel>(repeating: .createDummy(), count: 5)))
    }
}
