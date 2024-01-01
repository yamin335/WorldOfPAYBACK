//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 28.06.23.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
    init() {
        SystemUIDesign.apply()
    }
    var body: some Scene {
        WindowGroup {
            MainContentView().environmentObject(AppState())
        }
    }
}
