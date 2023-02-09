//
//  ImageDetailsViewModel.swift
//  Pictures
//
//  Created by Fernando Garay on 09/02/2023.
//

import Foundation
import SwiftUI

extension ImageDetailsView {
    @MainActor class ViewModel: ObservableObject {

        // MARK: Properties

        var image: UIImage?
        var location: String?
        
        // MARK: Life Cycle
        
        init(image: UIImage?, location: String?) {
            self.image = image
            self.location = location
        }
        
        // MARK: Public Properites
        
        let templateImage: String = "template-image"
        
        let locationIcon: String = "location-icon"
       
        let tittle: String = "Picture Detail"
    }
}
