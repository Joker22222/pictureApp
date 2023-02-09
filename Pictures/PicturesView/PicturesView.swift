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
    
    // MARK: Properties
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Picture.date, ascending: true)], animation: .none)
    private var items: FetchedResults<Picture>
    @StateObject private var viewModel: ViewModel
    
    // MARK: Life Cycle
    
    init() {
        _viewModel = .init(wrappedValue: .init())
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns) {
                        if items.count == 0 {
                            Image(viewModel.templateImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(20)
                        }
                        ForEach(items) { item in
                            if let data = item.image {
                                if let image = UIImage(data: data) {
                                    NavigationLink {
                                        ImageDetailsView(viewModel: .init(image: image, location: item.location))
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
                Text(viewModel.buttonText)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)), Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        viewModel.getLocation()
                        
                    }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .toolbarBackground(
                    Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(viewModel.title)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }.tint(.black)
                .background(.white)
                .sheet(isPresented: $viewModel.showSheet, onDismiss: addItem) {
                    ImagePicker(sourceType: .camera, selectedImage: $viewModel.image)
                }
        }.accentColor(.white)
            .onAppear(perform: {viewModel.askForLocation()})
    }
}

// MARK: Core Data

extension PicturesView {
    func addItem() {
        let newItem = Picture(context: viewContext)
        newItem.location = viewModel.location
        newItem.image = self.viewModel.image.jpegData(compressionQuality: 1.0)
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
