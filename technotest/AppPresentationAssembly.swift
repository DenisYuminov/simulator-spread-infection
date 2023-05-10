//
//  AppPresentationAssembly.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import Foundation

protocol IAppPresentationAssembly: AnyObject {
    var dataCoordinator: IDataCoordinator { get }
    var modelingCoordinator: IModelingCoordinator { get }
    var dataAssembly: IDataAssembly { get }
    var modelingAssembly: IModelingAssembly { get }
}

final class AppPresentationAssembly: IAppPresentationAssembly {
    
    // MARK: Coordinators
    var dataCoordinator: IDataCoordinator {
        DataCoordinator(assembly: dataAssembly, modelingCoordinator: modelingCoordinator)
    }
    
    var modelingCoordinator: IModelingCoordinator {
        ModelingCoordinator(assembly: modelingAssembly)
    }
    
    // MARK: Assembly
    
    var dataAssembly: IDataAssembly {
        DataAssembly()
    }

    var modelingAssembly: IModelingAssembly {
        ModelingAssembly()
    }
}
