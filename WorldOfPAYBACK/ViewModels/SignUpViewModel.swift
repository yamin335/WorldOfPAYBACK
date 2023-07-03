//
//  SignUpViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import Foundation
import Combine

enum PasswordValidity {
    case invalidPassword
    case validPassword
    case invalidFirstPassword
    case invalidSecondPassword
}

class SignUpViewModel: BaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    var signUpStatusPublisher = PassthroughSubject<Bool, Never>()
    
    var validatedEmail: AnyPublisher<Bool, Never> {
        return $email
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                let regexPattern = AppConstants.emailValidator
                let range = email.range(of: regexPattern, options: .regularExpression)
                
                return !(email.isEmpty || range == nil)
        }
        .eraseToAnyPublisher()
    }
    
    var validatedPassword: AnyPublisher<PasswordValidity, Never> {
        return Publishers.CombineLatest($password, $confirmPassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { password, confirmPassword in
                if password.isEmpty {
                    return .invalidFirstPassword
                } else if confirmPassword.isEmpty {
                    return.invalidSecondPassword
                } else if !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword{
                    return .validPassword
                }
                return .invalidPassword
        }
        .eraseToAnyPublisher()
    }
    
    var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validatedEmail, validatedPassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { isValidEmail, isValidPassword in
                return isValidEmail && isValidPassword == .validPassword
        }
        .eraseToAnyPublisher()
    }
    
    @MainActor
    func signUp() async {
        // Implement real api call here later
        var temp: [UserAccount] = []
        if let users = session.registeredUsers?.users {
            temp = users
        }
        
        temp.append(UserAccount(id: Int.random(in: 1..<1000), email: email, password: password, retypepassword: confirmPassword))
        session.registeredUsers = RegisteredUsers(users: temp)
        
        showLoader()
        try? await Task.sleep(for: .seconds(AppConstants.mockWaitingTime))
        self.showSuccessMsg(msg: "Account created successfully!")
        self.signUpStatusPublisher.send(true)
        self.hideLoader()
    }
}
