//
//  OutlinedButtonStyle.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

public struct OutlinedButtonStyle: ButtonStyle {
    public init() { }
    
    public func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .font(.system(size: 15, weight: .regular, design: .default))
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color("blue2_ripple") : .white)
            .cornerRadius(30)
            .foregroundColor(configuration.isPressed ? Color("blue2_dark") : Color("blue2") )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(configuration.isPressed ? Color("blue2_dark") : Color("blue2"), lineWidth: configuration.isPressed ? 2 : 1)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}

public extension Button {
    func outlinedButtonStyle() -> some View {
        return buttonStyle(OutlinedButtonStyle())
    }
}
