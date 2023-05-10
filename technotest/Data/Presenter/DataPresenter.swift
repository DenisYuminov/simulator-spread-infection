//
//  DataPresenter.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import Foundation

protocol DataPresenterOutput: AnyObject {
    func showModeling(size: Int, factor: Int, period: Int)
}

final class DataPresenter {
    
    // Dependencies
    weak var view: DataViewInput?
    private let output: DataPresenterOutput?
    
    // MARK: Init
    init(output: DataPresenterOutput?) {
        self.output = output
    }
}

// MARK: DataViewOuput
extension DataPresenter: DataViewOutput {
    func startModeling(size: Int, factor: Int, period: Int) {
        output?.showModeling(size: size, factor: factor, period: period)
    }
}
