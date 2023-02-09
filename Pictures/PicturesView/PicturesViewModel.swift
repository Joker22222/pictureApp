//
//  PicturesViewModel.swift
//  Pictures
//
//  Created by Fernando Garay on 09/02/2023.
//

import Foundation
import SwiftUI
import CoreLocation

extension PicturesView {
    @MainActor class ViewModel: ObservableObject {
       
        // MARK: Public Properties
        
        @Published  var showSheet = false
        @Published  var location : String = ""
        @Published  var image = UIImage()
        
        let locManager = CLLocationManager()
        let columns = [
            GridItem(.adaptive(minimum: 100, maximum: 150)),
        ]
        let templateImage: String = "template-image"
        let buttonText: String = "Take Picture"
        let title: String = "Pictures"
        
        // MARK: Public Methods
        
        func getLocation() {
            let currentLocation = locManager.location
            if let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude {
                let cityCoords = CLLocation(latitude: latitude, longitude: longitude)
                getAdressName(coords: cityCoords)
            }
        }
        
        func askForLocation(){
            locManager.requestAlwaysAuthorization()
        }
        
        func getAdressName(coords: CLLocation) {
            CLGeocoder().reverseGeocodeLocation(coords) { [weak self] (placemark, error) in
                if error != nil {
                    print("Error Getting Location")
                } else {
                    let place = placemark! as [CLPlacemark]
                    if place.count > 0 {
                        let place = placemark![0]
                        var adressString : String = ""
                        if place.thoroughfare != nil {
                            adressString = adressString + place.thoroughfare! + ", "
                        }
                        if place.subThoroughfare != nil {
                            adressString = adressString + place.subThoroughfare! + "\n"
                        }
                        if place.locality != nil {
                            adressString = adressString + place.locality! + " - "
                        }
                        if place.postalCode != nil {
                            adressString = adressString + place.postalCode! + "\n"
                        }
                        if place.subAdministrativeArea != nil {
                            adressString = adressString + place.subAdministrativeArea! + " - "
                        }
                        if place.country != nil {
                            adressString = adressString + place.country!
                        }
                        self?.location = adressString
                        self?.showSheet = true
                    }
                }
            }
        }
    }
}
