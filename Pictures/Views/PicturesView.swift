//
//  ContentView.swift
//  Pictures
//
//  Created by Fernando Garay on 01/02/2023.
//

import SwiftUI
import CoreData
import CoreLocation

struct PicturesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Picture.date, ascending: true)],
        animation: .none)
    
    private var items: FetchedResults<Picture>
    private let locManager = CLLocationManager()
    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150)),
    ]
    
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var location : String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        if items.count == 0 {
                            Image("template-image")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(20)
                        }
                        ForEach(items) { item in
                            if let data = item.image {
                                if let image = UIImage(data: data) {
                                    NavigationLink {
                                        ImageDetailsView(image: image, location: item.location)
                                    } label: {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                    }.padding(.init(top: 15, leading: 20, bottom: 0, trailing: 20))
                }
                Text("Take Picture")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        save()
                        
                    }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Pictures")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                }.tint(.black)
                .background(.white)
                .sheet(isPresented: $showSheet, onDismiss: addItem) {
                    ImagePicker(sourceType: .camera, selectedImage: $image)
                }
        }.accentColor(.black)
        .onAppear(perform: askForLocation)
    }
}

// MARK: Location

extension PicturesView {
    private func askForLocation(){
        locManager.requestAlwaysAuthorization()
    }
    
    func getAdressName(coords: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(coords) { (placemark, error) in
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
                    location = adressString
                    showSheet = true
                }
            }
        }
    }
}

// MARK: Core Data Methods

extension PicturesView {
    private func save(){
        let currentLocation = locManager.location
        if let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude {
            let cityCoords = CLLocation(latitude: latitude, longitude: longitude)
            getAdressName(coords: cityCoords)
        }
    }
    
    private func addItem() {
        let newItem = Picture(context: viewContext)
        newItem.location = location
        newItem.image = self.image.jpegData(compressionQuality: 1.0)
        newItem.date = Date.now
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PicturesView()
    }
}
