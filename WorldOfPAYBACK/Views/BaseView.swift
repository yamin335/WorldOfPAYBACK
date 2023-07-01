//
//  BaseView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 01.07.23.
//

import Foundation
import SwiftUI

struct BaseView<T: View, V: BaseViewModel>: View {
    @EnvironmentObject var appState: AppState
    var contentView: T
    var viewModel: V

    init(viewModel: V, @ViewBuilder content: () -> T) {
        self.contentView = content()
        self.viewModel = viewModel
    }

    var body: some View {
        contentView
            .onReceive(self.viewModel.isShowLoader.receive(on: RunLoop.main)) { isShowing in
                withAnimation {
                    self.appState.isLoading = isShowing
                }
            }.onReceive(self.viewModel.successMsgPublisher.receive(on: RunLoop.main)) {
                showToast, message in
                self.appState.successMessage = message
                withAnimation(.easeIn(duration: AppConstants.toastTime)) {
                    self.appState.isShowingSuccessMsg = showToast
                }
            }.onReceive(self.viewModel.errorMsgPublisher.receive(on: RunLoop.main)) {
                showToast, message in
                self.appState.errorMessage = message
                withAnimation(.easeIn(duration: AppConstants.toastTime)) {
                    self.appState.isShowingErrorMsg = showToast
                }
            }
    }
}
