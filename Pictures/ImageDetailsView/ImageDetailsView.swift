//
//  ImageDetailsView.swift
//  Pictures
//
//  Created by Fernando Garay on 03/02/2023.
//

import SwiftUI

struct ImageDetailsView: View {
    
    // MARK: Properties
    
    @StateObject private var viewModel: ViewModel
    
    // MARK: Life Cycle

    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: viewModel.image ?? UIImage(named: viewModel.templateImage)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                VStack {
                    Image(uiImage:UIImage(named: viewModel.locationIcon)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Text(viewModel.location ?? "")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }.padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
                Spacer()
            }.padding(.init(top: 25, leading: 20, bottom: 0, trailing: 20))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(viewModel.tittle)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                }.tint(.black)
                .toolbarBackground(
                    Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .background(.white)
        }
    }
}

struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView(viewModel: .init(image: UIImage(named: "template-image"), location: "Corrientes"))
    }
}
