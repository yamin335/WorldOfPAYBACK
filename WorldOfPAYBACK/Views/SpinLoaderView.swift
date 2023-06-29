//
//  SpinLoaderView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation
import SwiftUI

struct SpinLoaderView: View {
    
    @State var spinCircle = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0.3, to: 1)
                .stroke(Color.green, lineWidth:4)
                .frame(width:40, height: 40)
                .padding(.all, 8)
                .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                .animation(Animation.linear(duration: 0.6).repeatForever(autoreverses: false), value: spinCircle)
                .onAppear {
                    self.spinCircle = true
                }
            Text("Please wait...").foregroundColor(Color("gray3"))
        }
        .background(RoundedRectangle(cornerRadius: 8).fill(Color("gray1")).frame(width:150, height: 125).cornerRadius(8).shadow(color: Color("shadowColor"), radius: 6, x: 1, y: 2))
    }
}

struct SpinLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        SpinLoaderView()
    }
}
