//
//  SplashScreenViewModel.swift
//  Pictures
//
//  Created by Fernando Garay on 09/02/2023.
//

import Foundation

extension SplashScreenView {
    @MainActor class ViewModel: ObservableObject {
       
        // MARK: Properites
        
        let logoImage: String = "logo-image"
        let loadingText: String = "Loading..."
    }
}
