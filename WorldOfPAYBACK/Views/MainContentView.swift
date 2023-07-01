//
//  MainContentView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var appState: AppState
    private let session = SessionManager.shared
    @StateObject var networkObserver = NetworkObserver()
    
    var body: some View {
        ZStack {
            if appState.isSplashShown {
                if appState.isLoggedIn {
                    BottomTabContainerView().transition(.fadeInFadeOut)
                } else {
                    LoginView().transition(.fadeInFadeOut)
                }
            } else {
                SplashView()
            }
            
            if self.appState.isShowingSuccessMsg {
                SuccessToastView(message: self.appState.successMessage)
                    .zIndex(8)
                    .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.toastStayTime) {
                        withAnimation(.easeOut(duration: AppConstants.toastTime)) {
                            self.appState.isShowingSuccessMsg = false
                            self.appState.successMessage = ""
                        }
                    }
                }
            }

            if self.appState.isShowingErrorMsg {
                ErrorToastView(message: self.appState.errorMessage)
                    .zIndex(9)
                    .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.toastStayTime) {
                        withAnimation(.easeOut(duration: AppConstants.toastTime)) {
                            self.appState.isShowingErrorMsg = false
                            self.appState.errorMessage = ""
                        }
                    }
                }
            }

            if self.appState.isLoading {
                SpinLoaderView().transition(.fadeInFadeOut).zIndex(10)
            }
        }
        .onReceive(self.networkObserver.networkStatusPublisher.receive(on: RunLoop.main)) { status in
            self.appState.isConnected = status == .connected
            if status == .connected {
                if AppConstants.appLaunched {
                    self.appState.successMessage = AppConstants.connectedMsg
                    withAnimation(.easeIn(duration: AppConstants.toastTime)) {
                        self.appState.isShowingSuccessMsg = true
                    }
                }
            } else {
                self.appState.errorMessage = AppConstants.disConnectedMsg
                withAnimation(.easeIn(duration: AppConstants.toastTime)) {
                    self.appState.isShowingErrorMsg = true
                }
            }
            AppConstants.appLaunched = true
        }
        .onAppear {
            let users = session.registeredUsers?.users
            if users == nil {
                session.registeredUsers = RegisteredUsers(users: [UserAccount(id: 0, email: AppConstants.defaultEmail, password: AppConstants.defaultPassword, retypepassword: AppConstants.defaultPassword)])
            }
            networkObserver.startObserving()
        }
        .onDisappear {
            networkObserver.stopObserving()
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView().environmentObject(AppState())
    }
}
