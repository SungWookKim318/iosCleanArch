//
//  MoviesListTableView.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import SwiftUI

struct MoviesListTableView: View {
    @Binding var movies: [MoviesListItemViewModel]
    @State var selectedIndex: Int?
    var selectedAction: (Int) -> Void
    
    var body: some View {
        List {
            ForEach((0..<movies.count), id: \.self) { index in
                MoviesListItemView(itemViewModel: movies[index])
                    .listRowBackground(self.selectedIndex == index ? Color.gray.animation(selectAnimationDuration) : Color.white.animation(selectAnimationDuration))
                    .onTapGesture {
                        self.selectedIndex = index
                        selectedAction(index)
                    }
            }
        }
    }
    
    private let selectAnimationDuration = Animation.easeInOut(duration: 0.3)
}

struct MoviesListTableView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListTableView(movies: .constant([MoviesListItemViewModel](repeating: .createDummy(), count: 5)), selectedAction: { print("select \($0)")})
        MoviesListTableView(movies: .constant([]), selectedAction: { print("select \($0)")})
    }
}
