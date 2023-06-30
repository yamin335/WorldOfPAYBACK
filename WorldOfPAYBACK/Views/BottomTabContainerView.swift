//
//  BottomTabContainerView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

struct BottomTabContainerView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection.animation(.easeOut)){
            TransactionView().tabItem {
                Label("Transactions", systemImage: "eurosign.circle.fill")
            }
            .tag(0)
            
            SettingsView().tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(1)
        }.accentColor(Color("blue2")).edgesIgnoringSafeArea(.top)
    }
}

struct BottomTabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabContainerView()
    }
}
