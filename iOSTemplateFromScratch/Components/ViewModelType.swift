//
//  ViewModelType.swift
//  templateMVVM
//
//  Created by Benoit Pasquier on 22/2/19.
//  Copyright © 2019 Benoit Pasquier. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
