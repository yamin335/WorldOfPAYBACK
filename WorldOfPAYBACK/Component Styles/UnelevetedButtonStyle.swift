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
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .font(.system(size: 15, weight: .regular, design: .default))
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color("blue2_dark") : Color("blue2"))
            .cornerRadius(30)
            .foregroundColor(configuration.isPressed ? .white : Color("gray2") )
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}

public extension Button {
    func unelevetedButtonStyle() -> some View {
        return buttonStyle(UnelevetedButtonStyle())
    }
}
