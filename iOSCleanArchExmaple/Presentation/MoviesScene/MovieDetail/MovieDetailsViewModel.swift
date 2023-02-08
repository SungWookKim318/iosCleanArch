//
//  MovieDetailsViewModel.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/08.
//

import Foundation
import UIKit

class MovieDetailsViewModel: ObservableObject {
    struct PosterImageData {
        let image: UIImage
        
        public enum DefaultImage: String {
            case loadingImage = "stopwatch.fill"
            case networkFail = "externaldrive.badge.xmark"
            case imageInvalid = "xmark.circle.fill"
            case imageNotFound = "questionmark.square"
        }
        
        private init(image: UIImage) {
            self.image = image
        }
        
        static func createSystemImage(systemName: String) -> PosterImageData? {
            guard let systemImage = UIImage(systemName: systemName) else { return nil }
            return .init(image: systemImage)
        }
        
        static func createDefaultImage(type: DefaultImage = .loadingImage) -> PosterImageData {
            return .createSystemImage(systemName: type.rawValue)!
        }
        
        static func createImage(rawData: Data) -> PosterImageData? {
            guard let image = UIImage(data: rawData) else { return nil }
            return .init(image: image)
        }
    }
    
    let title: String
    let isPosterImageHidden: Bool
    let overview: String
    let posterPath: String?
    @Published var posterImageData: PosterImageData = .createDefaultImage()
    
    private let posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? = nil
    
    init(title: String, isPosterImageHidden: Bool, overview: String, posterPath: String? = nil, posterImagesRepository: PosterImagesRepository? = nil) {
        self.title = title
        self.isPosterImageHidden = isPosterImageHidden
        self.overview = overview
        self.posterPath = posterPath
        self.posterImagesRepository = posterImagesRepository
    }
    
    convenience init(movie: Movie, posterImagesRepository: PosterImagesRepository) {
        self.init(title: movie.title ?? "",
                  isPosterImageHidden: movie.posterPath == nil,
                  overview: movie.overview ?? "",
                  posterPath: movie.posterPath,
                  posterImagesRepository: posterImagesRepository)
    }
    
    public func requestUpdatePoster() {
        print("request Poster Update")
        guard let posterPath = self.posterPath else {
            print("poster path is empty")
            posterImageData = .createDefaultImage(type: .imageNotFound)
            return
        }
        let width = Int(UIScreen.main.bounds.width * UIScreen.main.scale)
        imageLoadTask = posterImagesRepository?.fetchImage(with: posterPath, width: width, completion: { [weak self] result in
            let newImageData: PosterImageData
            switch result {
            case .success(let success):
                if let imageData = PosterImageData.createImage(rawData: success) {
                    newImageData = imageData
                } else {
                    print("fail to get image by converting raw data")
                    newImageData = .createDefaultImage(type: .imageInvalid)
                }
            case .failure(let failure):
                print("fail to get image \(failure)")
                newImageData = .createDefaultImage(type: .networkFail)
            }
            // DO Main Thread?
            self?.posterImageData = newImageData
        })
    }
}

extension MovieDetailsViewModel {
    static func createDummy(isPosetHidden: Bool) -> MovieDetailsViewModel {
        return .init(title: "Test Item", isPosterImageHidden: isPosetHidden, overview: "테스트 아이템\nTest Item")
    }
}
