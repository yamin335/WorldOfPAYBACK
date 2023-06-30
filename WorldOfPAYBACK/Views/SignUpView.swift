//
//  SignUpView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = SignUpViewModel()
    @State private var signUpButtonDisabled = true
    
    @State var showEmailWarning = false
    @State var showPasswordWarning = false
    @State var showConfirmPasswordWarning = false
    
    @FocusState private var focusedField: Field?
    @State var emailFieldFocused = false
    @State var passwordFieldFocused = false
    @State var confirmPasswordFieldFocused = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Text("If you already have an account, please")
                    .foregroundColor(.gray).font(.subheadline)
                Button(action: {
                    withAnimation() {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(Color("blue2"))
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
            
            Group {
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
                
                SecureField("Password", text: $viewModel.password)
                    .focused($focusedField, equals: .password)
                    .textFieldStyle(RoundedTextFieldStyle(focused: $passwordFieldFocused))
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
            }
            
            Group {
                if showPasswordWarning {
                    Text("Invalid password!")
                        .textStyle(ErrorTextStyle())
                        .padding(.horizontal, 30)
                }
                
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
            
            Group {
                Button("Sign Up") {
                    self.viewModel.signUp()
                }
                .unelevetedButtonStyle()
                .padding(.horizontal, 20)
                .padding(.top, 25)
                .padding(.bottom, 20)
                .disabled(signUpButtonDisabled)
                
                Spacer()
                
                Text("All rights reserved. Copyright ©2023, PAYBACK Group.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
            }
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
                    withAnimation() {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .background(Color("grayBlue1"))
        .navigationTitle("Create Your Account")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
