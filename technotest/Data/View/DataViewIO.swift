//
//  DataViewIO.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import Foundation

protocol DataViewOutput: AnyObject {
    func startModeling(size: Int, factor: Int, period: Int)
}

protocol DataViewInput: AnyObject {
}
