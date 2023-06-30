//
//  TransactionCategory.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import Foundation

enum TransactionCategory: Int, CaseIterable, Identifiable {
    case all = 0, type_1 = 1, type_2 = 2, type_3 = 3
    var id: Self { self }
    var title: String  {
        var title = "All"
        if self.rawValue == 1 {
            title = "Category - 1"
        } else if self.rawValue == 2 {
            title = "Category - 2"
        } else if self.rawValue == 3 {
            title = "Category - 3"
        }
        return title
    }
}
