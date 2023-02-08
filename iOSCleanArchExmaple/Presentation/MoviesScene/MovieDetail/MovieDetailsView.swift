//
//  MovieDetailsView.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/08.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movieDetailViewModel: MovieDetailsViewModel
    var body: some View {
        VStack(spacing: 10) {
            if !movieDetailViewModel.isPosterImageHidden {
                convertImage()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, idealHeight: 200)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    .cornerRadius(5)
            }
            ScrollView {
                Text(movieDetailViewModel.overview)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            }
//            Spacer()
        }.onAppear {
            movieDetailViewModel.requestUpdatePoster()
        }
        .navigationBarTitle(movieDetailViewModel.title, displayMode: .automatic)
        .navigationBarHidden(false)
    }
    
    func convertImage() -> Image {
        Image(uiImage: movieDetailViewModel.posterImageData.image)
            .resizable()
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movieDetailViewModel: .createDummy(isPosetHidden: true))
        MovieDetailsView(movieDetailViewModel: .createDummy(isPosetHidden: false))
    }
}
