//
//  ListEmptyView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 01.07.23.
//

import SwiftUI

struct ListEmptyView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Unable to load data!")
                .font(.system(size: 18, weight: .light))
                .foregroundColor(Color("shadowColor"))
            
            Label("Swipe from top to refresh again", systemImage: "arrow.down")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color("gray3"))
        }
    }
}

struct ListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyView()
    }
}
