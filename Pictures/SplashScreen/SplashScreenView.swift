//
//  SplashScreenView.swift
//  Pictures
//
//  Created by Fernando Garay on 06/02/2023.
//

import SwiftUI

import SwiftUI

struct SplashScreenView: View {
    
    // MARK: Properties
    
    let persistenceController = PersistenceController.shared
   
    @StateObject private var viewModel: ViewModel
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // MARK: Life Cycle

    init() {
        _viewModel = .init(wrappedValue: .init())
    }
    
    var body: some View {
        if isActive {
            PicturesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } else {
            VStack {
                VStack {
                    Image(viewModel.logoImage).resizable()
                    
                        .aspectRatio(contentMode: .fit)
                    Text(viewModel.loadingText)
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
