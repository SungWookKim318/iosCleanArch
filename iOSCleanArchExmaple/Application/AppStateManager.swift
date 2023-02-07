//
//  AppStateManager.swift
//  iOSCleanArchExmaple
//
//  Created by FitnessCandy on 2023/02/07.
//

import Foundation
import UIKit

class AppStateManager {
    private init() {
        
    }
    
    let appDIContainer = AppDIContainer()
    private(set) var appFlowCoordinator: AppFlowCoordinator?
    
    static let share = AppStateManager()
    
    public func createFlowCoordinator(navigationController: UINavigationController) {
        appFlowCoordinator = .init(navigationController: navigationController, appDIContainer: self.appDIContainer)
    }
}
