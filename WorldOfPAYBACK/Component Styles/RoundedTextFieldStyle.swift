//
//  RoundedSecureField.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    let cornerRadius: CGFloat = 8.0

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
        // Make sure no other style is mistakenly applied.
        .textFieldStyle(PlainTextFieldStyle())
        // Text alignment.
        .multilineTextAlignment(.leading)
        // Cursor color.
        .accentColor(Color("blue2"))
        // Text color.
        .foregroundColor(.black)
        // Text/placeholder font.
        //.font(.title.weight(.semibold))
        // TextField padding.
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        // TextField border.
        .background(.white)
        .cornerRadius(cornerRadius)
        .overlay {
            border
        }

    }
    
    var border: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(
                LinearGradient(
                    gradient: .init(
                        colors: [
                            Color("blue2_dark"),
                            Color("blue2")
                        ]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                lineWidth: focused ? 2 : 1
            ).shadow(color: Color("shadowColor"), radius: focused ? 5 : 0, x: focused ? 1 : 0, y: focused ? 2 : 0)
    }
}
