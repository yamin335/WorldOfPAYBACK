//
//  SettingsView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 30.06.23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = SettingsViewModel()
    @State var transactionAlertControl: Bool = true
    @State var onlyCreditAlertControl: Bool = false
    @State var onlyDebitAlertControl: Bool = false
    @State var isPresented: Bool = false
    
    var body: some View {
        BaseView(viewModel: viewModel) {
            Form {
                Section("Alert settings") {
                    Toggle("Transaction alert", isOn: $transactionAlertControl)
                    Toggle("Only debit alert", isOn: $onlyDebitAlertControl)
                    Toggle("Only credit alert", isOn: $onlyCreditAlertControl)
                }
                
                Section("Logout from app") {
                    Button("Logout") {
                        isPresented.toggle()
                    }
                    .buttonStyle(OutlinedButtonStyle())
                    .padding(.vertical)
                }
            }
            .confirmationDialog("Logout Reminder", isPresented: $isPresented) {
                Button("Yes, Logout", role: .destructive) {
                    self.viewModel.session.isLoggedIn = false
                    self.appState.isLoggedIn = false
                    self.viewModel.showSuccessMsg(msg: "Successfylly logged out")
                }
                Button("Not now", role: .cancel) {
                    isPresented = false
                }
            } message: {
                Text("Do you want to logout from the app?")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
