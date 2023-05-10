//
//  AppCoordinator.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import Foundation
import UIKit

final class AppCoordinator {
    // Dependencies
    private let dataCoordinator: IDataCoordinator
    
    // MARK: Init
    
    init(appPresentationAssembly: IAppPresentationAssembly) {
        self.dataCoordinator = appPresentationAssembly.dataCoordinator
    }
    
    // MARK: Internal
    
    func createRootViewController() -> UIViewController {
        dataCoordinator.createFlow()
    }
}
