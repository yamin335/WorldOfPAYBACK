//
//  SystemUIDesign.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 03.10.23.
//

import Foundation
import UIKit

struct SystemUIDesign {
    private init() {}
    @MainActor
    static func apply() {
        // correct the transparency bug for Tab bars
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
