//
//  ModelingPresenter.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import Foundation

protocol ModelingPresenterOutput: AnyObject {
}

final class ModelingPresenter {
    
    // Dependencies
    weak var view: ModelingViewInput?
    private let output: ModelingPresenterOutput?
    
    // MARK: Init
    init(output: ModelingPresenterOutput?) {
        self.output = output
    }
}

extension ModelingPresenter: ModelingViewOutput {
    
}
