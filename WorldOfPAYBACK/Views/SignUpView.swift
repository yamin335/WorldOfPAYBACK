//
//  SignUpView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct SignUpView: View {
    static let tag = "SignUpView"
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = SignUpViewModel()
    @Binding var path: NavigationPath
    @State private var signUpButtonDisabled = true
    
    @State var showEmailWarning = false
    @State var showPasswordWarning = false
    @State var showConfirmPasswordWarning = false
    
    @FocusState private var focusedField: Field?
    @State var emailFieldFocused = false
    @State var passwordFieldFocused = false
    @State var confirmPasswordFieldFocused = false
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            VStack(spacing: 0) {
                signInInstruction
                emailView
                passwordView
                confirmPasswordView
                signUpButton
                Spacer()
                
                Text("All rights reserved. Copyright ©2023, PAYBACK Group.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                .onChange(of: focusedField, perform: { newValue in
                    withAnimation(.linear(duration: 0.2)) {
                        emailFieldFocused = newValue == .email
                        passwordFieldFocused = newValue == .password
                        confirmPasswordFieldFocused = newValue == .confirmPassword
                    }
                })
                .onReceive(self.viewModel.validatedEmail.receive(on: RunLoop.main)) { isValid in
                    withAnimation(.linear(duration: 0.2)) {
                        self.showEmailWarning = !isValid
                    }
                }
                .onReceive(self.viewModel.validatedPassword.receive(on: RunLoop.main)) { isValid in
                    withAnimation(.linear(duration: 0.2)) {
                        self.showPasswordWarning = isValid == .invalidFirstPassword
                    }
                }
            }
            .onReceive(self.viewModel.validatedPassword.receive(on: RunLoop.main)) { isValid in
                withAnimation(.linear(duration: 0.2)) {
                    self.showConfirmPasswordWarning = isValid == .invalidSecondPassword || isValid == .invalidPassword
                }
            }
            .onReceive(self.viewModel.validatedCredentials.receive(on: RunLoop.main)) { validCredential in
                self.signUpButtonDisabled = !validCredential
            }.onReceive(self.viewModel.signUpStatusPublisher.receive(on: RunLoop.main)) { isSuccess in
                if isSuccess {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        while path.count > 0 {
                            withAnimation() {
                                path.removeLast()
                            }
                        }
                    }
                }
            }
            .background(Color("grayBlue1"))
            .navigationTitle("Create Your Account")
        }
    }
    
    private var signInInstruction: some View {
        HStack(alignment: .center) {
            Text("If you already have an account, please")
                .foregroundColor(.gray).font(.subheadline)
            Button(action: {
                while path.count > 0 {
                    withAnimation() {
                        path.removeLast()
                    }
                }
            }) {
                Text("Sign In")
                    .foregroundColor(Color("blue2"))
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
    
    private var emailView: some View {
        VStack(spacing: 0) {
            TextField("Email", text: $viewModel.email)
                .focused($focusedField, equals: .email)
                .textFieldStyle(RoundedTextFieldStyle(focused: $emailFieldFocused))
                .padding(.horizontal, 20)
                .padding(.top, 20)
            
            if showEmailWarning {
                Text("Invalid email!")
                    .textStyle(ErrorTextStyle())
                    .padding(.horizontal, 30)
            }
        }
    }
    
    private var passwordView: some View {
        VStack(spacing: 0) {
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
        }
    }
    
    private var confirmPasswordView: some View {
        VStack(spacing: 0) {
            SecureField("Re-Type Password", text: $viewModel.confirmPassword)
                .focused($focusedField, equals: .confirmPassword)
                .textFieldStyle(RoundedTextFieldStyle(focused: $confirmPasswordFieldFocused))
                .padding(.horizontal, 20)
                .padding(.top, 15)
            
            if showConfirmPasswordWarning {
                Text("Invalid Re-Type password!")
                    .textStyle(ErrorTextStyle())
                    .padding(.horizontal, 30)
            }
        }
    }
    
    private var signUpButton: some View {
        Button("Sign Up") {
            if appState.isConnected {
                Task {
                    await self.viewModel.signUp()
                }
            } else {
                self.viewModel.showErrorMsg(msg: AppConstants.networkErrorMsg)
            }
        }
        .unelevetedButtonStyle()
        .padding(.horizontal, 20)
        .padding(.top, 25)
        .padding(.bottom, 20)
        .disabled(signUpButtonDisabled)
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var path: NavigationPath = .init()
    static var previews: some View {
        SignUpView(path: $path)
    }
}
