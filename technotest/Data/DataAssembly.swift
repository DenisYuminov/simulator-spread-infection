//
//  DataAssembly.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import UIKit

protocol IDataAssembly: AnyObject {
    func build(output: DataPresenterOutput) -> UIViewController
}

final class DataAssembly: IDataAssembly {
    // MARK: IDataAssembly
    
    func build(output: DataPresenterOutput) -> UIViewController {
        let presenter = DataPresenter(output: output)
        let view = ViewController(output: presenter)
        presenter.view = view
        return view
    }
}
