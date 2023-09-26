//
//  Extensions.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
    
    static var fadeInFadeOut: AnyTransition {
        .asymmetric(
            insertion: .opacity,
            removal: .opacity
        )
    }
}

extension Date? {
    func toFormattedDateString() -> String? {
        return self?.formatted(.dateTime.year().day().month(.abbreviated).hour().minute())
    }
}

extension Transaction {
    func parseAmount() -> String {
        let amount = self.transactionDetail?.value?.amount ?? 0
        let currency = self.transactionDetail?.value?.currency ?? AppConstants.defaultCurrency
        return amount.formatted(.currency(code: currency))
    }
}
