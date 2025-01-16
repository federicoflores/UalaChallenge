//
//  PlaceRowView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct PlaceRowView: View {
    typealias ButtonCompletion = ((Bool)->())
    
    let ualaPlace: UalaPlace
    @State var isFavorite: Bool
    var completion: ButtonCompletion?
    
    var body: some View {
        HStack {
            Button {
                isFavorite.toggle()
                completion?(isFavorite)
            } label: {
                Image(systemName: isFavorite ? "star.circle.fill" : "star.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .leading)
                    .tint(.yellow)
            }
                .frame(maxWidth: 50, maxHeight: 50)
                .padding(4)
            VStack(alignment: .leading) {
                Text(ualaPlace.name + " - " + ualaPlace.country)
                    .font(.system(size: 24, weight: .bold, design: .monospaced))
                    .lineLimit(1)
                    .padding(0)
                    .minimumScaleFactor(0.8)
                HStack {
                    Text("Lat :" + "\(ualaPlace.coordinate.latitude)")
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                        .padding(0)
                    Text("-")
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                    Text("Lon: " + "\(ualaPlace.coordinate.longitude)")
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PlaceRowView(ualaPlace: UalaPlace(country: "Arg", name: "Buenos Aires", id: 187871, coordinate: Coordinate(longitude: -8263673, latitude: -1716152.2), isFavorite: false), isFavorite: false, completion: nil)
}

