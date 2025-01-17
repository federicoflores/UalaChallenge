//
//  PlaceRowView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct PlaceRowView: View {
    
    private enum Constants {
        static let buttonMaxWidth: CGFloat = 50
        static let buttonMaxHeight: CGFloat = 50
        static let buttonMaxPadding: CGFloat = 4
        static let cityTextFontSize: CGFloat = 24
        static let textLineLimit = 1
        static let cityTextMinimunScale = 0.8
        static let starFillImage = "star.circle.fill"
        static let starImage = "star.circle"
        static let divider: String = " - "
    }
    
    private enum Wording {
        static let latitude: String = "Lat :"
        static let longitude: String = "Lon :"
    }
    
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
                Image(systemName: isFavorite ? Constants.starFillImage : Constants.starImage)
                    .resizable()
                    .scaledToFit()
                    .frame(alignment: .leading)
                    .tint(.blue)
            }
            .frame(maxWidth: Constants.buttonMaxWidth, maxHeight: Constants.buttonMaxWidth)
            .padding(Constants.buttonMaxPadding)
            VStack(alignment: .leading) {
                Text(ualaPlace.name + Constants.divider + ualaPlace.country)
                    .font(.system(size: Constants.cityTextFontSize, weight: .bold, design: .monospaced))
                    .lineLimit(Constants.textLineLimit)
                    .padding(.zero)
                    .minimumScaleFactor(Constants.cityTextMinimunScale)
                HStack {
                    Text(Wording.latitude + "\(ualaPlace.coordinate.latitude)")
                        .font(.subheadline)
                        .lineLimit(Constants.textLineLimit)
                        .foregroundColor(.gray)
                        .padding(.zero)
                    Text(Constants.divider)
                        .font(.subheadline)
                        .lineLimit(Constants.textLineLimit)
                        .foregroundColor(.gray)
                    Text(Wording.longitude + "\(ualaPlace.coordinate.longitude)")
                        .font(.subheadline)
                        .lineLimit(Constants.textLineLimit)
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

