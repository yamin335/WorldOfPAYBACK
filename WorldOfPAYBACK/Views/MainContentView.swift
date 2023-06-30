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
        }.onAppear {
            let users = session.registeredUsers?.users
            if users == nil {
                session.registeredUsers = RegisteredUsers(users: [UserAccount(id: 0, email: AppConstants.defaultEmail, password: AppConstants.defaultPassword, retypepassword: AppConstants.defaultPassword)])
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView().environmentObject(AppState())
    }
}
