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
            .font(.system(size: 20, weight: .bold))
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct AmountStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color("blue3"))
    }
}

struct FootNoteStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .light))
            .foregroundColor(Color("textColor4"))
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct DateStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10, weight: .light))
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
