//
//  AppConfiguration.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        return "2696829a81b1b5827d515ff121700838"
    }()
    lazy var apiBaseURL: String = {
        return "http://api.themoviedb.org"
    }()
    lazy var imagesBaseURL: String = {
        return "http://image.tmdb.org"
    }()
}
