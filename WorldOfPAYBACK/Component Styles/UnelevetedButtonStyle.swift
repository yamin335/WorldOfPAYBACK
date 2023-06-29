//
//  UnelevetedButtonStyle.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

public struct UnelevetedButtonStyle: ButtonStyle {
    public init() { }
    
    public func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        configuration.label
            .padding(.vertical, 20)
            .font(.system(size: 15, weight: .bold, design: .default))
            .textCase(.uppercase)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(configuration.isPressed ? Color.red : .white)
            .cornerRadius(30)
            .foregroundColor(configuration.isPressed ? .white : Color.red )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.red , lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

public extension Button {
    func brandStyle() -> some View {
        return buttonStyle(UnelevetedButtonStyle())
    }
}
