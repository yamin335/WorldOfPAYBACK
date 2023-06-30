//
//  TextStyles.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold))
            .lineSpacing(5)
            .foregroundColor(Color.blue )
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Hiragino Mincho ProN", size: 15))
            .lineSpacing(4)
            .foregroundColor(.secondary)
    }
}

struct ErrorTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .light))
            .foregroundColor(Color("red1"))
            .multilineTextAlignment(.leading)
            .padding(.top, 4)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}


extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
