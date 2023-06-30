//
//  SplashView.swift
//  WorldOfPAYBACK
//
//  Created by Md. Yamin on 29.06.23.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState
    @State var imageAlpha = 0.0
    let inTime = 0.7
    let outTime = 1.4
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack(alignment: .center) {
                Spacer()
                Image("app_icon")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .opacity(imageAlpha)
                    .onAppear(){
                        withAnimation(.easeIn(duration: inTime)) {
                            imageAlpha = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + outTime) {
                            withAnimation(.easeOut(duration: self.outTime)) {
                                self.imageAlpha = 0
                                self.appState.isSplashShown = true
                            }
                        }
                    }
                Spacer()
            }
            Spacer()
        }
        .background(Image("splash_background").resizable().scaledToFill())
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().environmentObject(AppState())
    }
}
