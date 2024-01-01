//
//  LoginViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""

    var loginStatusPublisher = PassthroughSubject<Bool, Never>()
    
    var validatedEmail: AnyPublisher<Bool, Never> {
        return $email
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { email in
                let regexPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
                let range = email.range(of: regexPattern, options: .regularExpression)
                
                return !(email.isEmpty || range == nil)
        }
        .eraseToAnyPublisher()
    }

    var validatedPassword: AnyPublisher<Bool, Never> {
        return $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return !password.isEmpty
        }
        .eraseToAnyPublisher()
    }
    
    var validatedCredentials: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest(validatedEmail, validatedPassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .receive(on: RunLoop.main) // <<—— run on main thread
            .map { isValidEmail, isValidPassword in
                return isValidEmail && isValidPassword
        }
        .eraseToAnyPublisher()
    }
    
    @MainActor
    func login() async {
        // Implement real api call here later
        guard let users = session.registeredUsers?.users else {
            self.loginStatusPublisher.send(false)
            self.showErrorMsg(msg: "Login failed! please check your credentials.")
            return
        }
        
        for user in users {
            if user.email == email && user.password == password {
                session.isLoggedIn = true
                break
            }
        }
        
        self.showLoader()
        
        try? await Task.sleep(for: .seconds(AppConstants.mockWaitingTime))
        
        if self.session.isLoggedIn {
            self.showSuccessMsg(msg: "Login successful!")
            self.loginStatusPublisher.send(true)
        } else {
            self.loginStatusPublisher.send(false)
            self.showErrorMsg(msg: "Login failed! please check your credentials.")
        }
        self.hideLoader()
    }
}
