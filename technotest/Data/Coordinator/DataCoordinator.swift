//
//  DataCoordinator.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import UIKit

protocol IDataCoordinator: AnyObject {
    func createFlow() -> UIViewController
}

final class DataCoordinator: IDataCoordinator, DataPresenterOutput {
    
    // Dependencies
    private let modelingCoordinator: IModelingCoordinator
    private let assembly: IDataAssembly
    
    // Properties
    private weak var transitionHandler: UINavigationController?
    
    // MARK: Init
    
    init(
        assembly: IDataAssembly,
        modelingCoordinator: IModelingCoordinator
    ) {
        self.assembly = assembly
        self.modelingCoordinator = modelingCoordinator
    }
    
    // MARK: IAuthCoordinator
    
    func createFlow() -> UIViewController {
        let viewController = assembly.build(output: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        transitionHandler = navigationController
        return navigationController
    }
    
    // MARK: DataPresenterOutput
    
    func showModeling(size: Int, factor: Int, period: Int) {
        let viewController = modelingCoordinator.createFlow(size: size, factor: factor, period: period)
        transitionHandler?.setViewControllers([viewController], animated: true)
    }
}
