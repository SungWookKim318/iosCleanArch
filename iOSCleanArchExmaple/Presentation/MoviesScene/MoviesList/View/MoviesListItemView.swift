//
//  MoviesListItemView.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import SwiftUI

struct MoviesListItemView: View {
    let itemViewModel: MoviesListItemViewModel
    var body: some View {
        HStack {
            VStack{
                Text(itemViewModel.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 11, leading: 8, bottom: 0, trailing: 0))
                
                Text(itemViewModel.releaseDate)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 3.5, leading: 8, bottom: 0, trailing: 0))
                
                Text(itemViewModel.overview)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 6, leading: 8, bottom: 11, trailing: 0))
            }
            .frame(maxHeight: 140)
            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            Spacer()
            requestImage
                .resizable()
                .frame(width: 80, height: 100, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
    
    private var requestImage: Image {
        guard let path = itemViewModel.posterImagePath else {
            return Image(systemName: "xmark")
        }
        return Image(systemName: "stopwatch")
    }
}

struct MoviesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListItemView(itemViewModel: .createDummy())
    }
}
