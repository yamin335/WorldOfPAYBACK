//
//  BooleanRandomGenerator.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 27.09.23.
//

import Foundation

protocol BooleanRandomGeneratorType {
    func random() -> Bool
}

struct BooleanRandomGenerator: BooleanRandomGeneratorType {
    func random() -> Bool {
        Bool.random()
    }
}
