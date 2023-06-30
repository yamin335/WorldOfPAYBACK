//
//  LoginView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

enum Field: Hashable {
    case email
    case password
    case confirmPassword
}

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = LoginViewModel()
    @State private var loginButtonDisabled = true
    private let session = SessionManager.shared
    
    @State var showEmailWarning = false
    @State var showPasswordWarning = false
    
    @FocusState private var focusedField: Field?
    @State var emailFieldFocused = false
    @State var passwordFieldFocused = false
    
    var body: some View {
        NavigationStack() {
            VStack(spacing: 0) {
                Text("WorldOfPAYBACK")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(Color("blue2"))
                    .padding(.top, 80)
                
                TextField("Email", text: $viewModel.email)
                    .focused($focusedField, equals: .email)
                    .textFieldStyle(RoundedTextFieldStyle(focused: $emailFieldFocused))
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                
                if showEmailWarning {
                    Text("Invalid email!")
                        .textStyle(ErrorTextStyle())
                        .padding(.horizontal, 30)
                }
                
                SecureField("Password", text: $viewModel.password)
                    .focused($focusedField, equals: .password)
                    .textFieldStyle(RoundedTextFieldStyle(focused: $passwordFieldFocused))
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                
                if showPasswordWarning {
                    Text("Invalid password!")
                        .textStyle(ErrorTextStyle())
                        .padding(.horizontal, 30)
                }
                
                Button("Sign In") {
                    self.viewModel.login()
                }
                .unelevetedButtonStyle()
                .padding(.horizontal, 20)
                .padding(.top, 15)
                .padding(.bottom, 20)
                .disabled(loginButtonDisabled)
                
                HStack(alignment: .center) {
                    Text("If you don't have an account yet, please")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color("blue2"))
                    }
                }
                .padding(.top, 1)
                
                Spacer()
                
                Text("All rights reserved. Copyright ©2023, PAYBACK Group")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
            .background(Color("grayBlue1"))
        }
        .navigationTitle("Sign In")
        .onChange(of: focusedField, perform: { newValue in
            withAnimation(.linear(duration: 0.2)) {
                emailFieldFocused = newValue == .email
                passwordFieldFocused = newValue == .password
            }
        })
        .onReceive(self.viewModel.validatedEmail.receive(on: RunLoop.main)) { isValid in
            withAnimation(.linear(duration: 0.2)) {
                self.showEmailWarning = !isValid
            }
        }
        .onReceive(self.viewModel.validatedPassword.receive(on: RunLoop.main)) { isValid in
            withAnimation(.linear(duration: 0.2)) {
                self.showPasswordWarning = !isValid
            }
        }
        .onReceive(self.viewModel.validatedCredentials.receive(on: RunLoop.main)) { validCredential in
            self.loginButtonDisabled = !validCredential
        }.onReceive(self.viewModel.loginStatusPublisher.receive(on: RunLoop.main)) { isLoggedIn in
            if isLoggedIn {
                withAnimation() {
                    self.appState.isLoggedIn = isLoggedIn
                }
            } else {
                setDefaultCredentials()
            }
        }.onReceive(self.viewModel.isShowLoader.receive(on: RunLoop.main)) { isShowing in
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
        }.onAppear {
            setDefaultCredentials()
        }
    }
    
    private func setDefaultCredentials() {
        guard let users = session.registeredUsers?.users else {
            return
        }
        
        for user in users {
            if user.id == 0 {
                self.viewModel.email = user.email ?? AppConstants.defaultEmail
                self.viewModel.password = user.password ?? AppConstants.defaultPassword
                break
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppState())
    }
}
