//
//  RoundedTextField.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

public struct RoundedTextField: View {
    var placeholder: LocalizedStringKey
    @Binding var text: String

    /// Whether the user is focused on this `TextField`.
    @State private var isEditing: Bool = false
    let cornerRadius: CGFloat = 8.0
    
    public init(_ placeholder: LocalizedStringKey, text: Binding<String>) {
      self.placeholder = placeholder
      self._text = text
    }
    
    public var body: some View {
        TextField(placeholder, text: $text, onEditingChanged: { val in
            withAnimation(.linear(duration: 0.2)) {
                isEditing = val
            }
        })
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
                lineWidth: isEditing ? 2 : 1
            ).shadow(color: Color("shadowColor"), radius: isEditing ? 5 : 0, x: isEditing ? 1 : 0, y: isEditing ? 2 : 0)
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        RoundedTextField("Placeholder", text: $text)
    }
}
