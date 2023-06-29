//
//  ContentView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 28.06.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var networkObserver = NetworkObserver()
    @State var connected: Bool = false
    
    var body: some View {
        VStack {
            if networkObserver.networkStatus == .connected {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Bye, world!")
            }
            
            if connected {
                Text("Connected!")
            } else {
                Text("Disconnected!")
            }
        }
        .padding()
        .onReceive(self.networkObserver.networkStatusPublisher.receive(on: RunLoop.main)) { status in
            self.connected = status == .connected
        }
        .onAppear {
            networkObserver.startObserving()
        }
        .onDisappear {
            networkObserver.stopObserving()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
