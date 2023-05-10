//
//  ModelingAssembly.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import UIKit

protocol IModelingAssembly: AnyObject {
    func build(output: ModelingPresenterOutput, size: Int, factor: Int, period: Int) -> UIViewController
}

final class ModelingAssembly: IModelingAssembly {
    // MARK: IModelingAssembly
    
    func build(output: ModelingPresenterOutput, size: Int, factor: Int, period: Int) -> UIViewController {
        let presenter = ModelingPresenter(output: output)
        let view = ModelingViewController(output: presenter, size: size, factor: factor, period: period)
        presenter.view = view
        return view
    }
}
