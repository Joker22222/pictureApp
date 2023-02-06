//
//  ImageDetailsView.swift
//  Pictures
//
//  Created by Fernando Garay on 03/02/2023.
//

import SwiftUI

struct ImageDetailsView: View {
    let image: UIImage?
    let location: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: image ?? UIImage(named: "template-image")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                VStack {
                    Image(uiImage:UIImage(named: "location-icon")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Text(location ?? "")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }.padding(.init(top: 40, leading: 20, bottom: 0, trailing: 20))
                Spacer()
            }.padding(.init(top: 25, leading: 20, bottom: 0, trailing: 20))
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Picture Detail")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                    }
                    
                }.tint(.black)
                .background(.white)
        }.background(.white)
    }
}

struct ImageDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailsView(image: UIImage(named: "template-image"), location: "Corrientes")
    }
}
