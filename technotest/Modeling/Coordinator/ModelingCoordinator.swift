//
//  ModelingCoordinator.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import UIKit

protocol IModelingCoordinator: AnyObject {
    func createFlow(size: Int, factor: Int, period: Int) -> UIViewController
}

final class ModelingCoordinator: IModelingCoordinator, ModelingPresenterOutput {
    
    // Dependencies
    private let assembly: IModelingAssembly
    
    // Properties
    private weak var transitionHandler: UIViewController?
    
    // MARK: Init
    
    init(
        assembly: IModelingAssembly
    ) {
        self.assembly = assembly
    }
    
    // MARK: IModelingCoordinator
    
    func createFlow(size: Int, factor: Int, period: Int) -> UIViewController {
        let viewController = assembly.build(output: self, size: size, factor: factor, period: period)
        return viewController
    }
}
