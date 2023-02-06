//
//  SplashScreenView.swift
//  Pictures
//
//  Created by Fernando Garay on 06/02/2023.
//

import SwiftUI

import SwiftUI

struct SplashScreenView: View {
    let persistenceController = PersistenceController.shared
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            PicturesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } else {
            VStack {
                VStack {
                    Image("logo-image").resizable()
                    
                        .aspectRatio(contentMode: .fit)
                    Text("Loading...")
                        .font(.largeTitle).bold()
                        .foregroundColor(.black.opacity(0.80))
                    Spacer()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }.background(.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
