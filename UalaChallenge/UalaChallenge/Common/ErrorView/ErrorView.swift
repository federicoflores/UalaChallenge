//
//  ErrorView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct ErrorView: View {
    
    fileprivate enum Constant {
        static let mainImageFrame: CGFloat = 300
        static let mainImagePadding: CGFloat = 60
        static let titleTextPadding: CGFloat = 12
        static let subtitleTextPadding: CGFloat = 70
        static let subtitleTextForegroundColorOpacity: CGFloat = 0.7
        static let retryButtonFrameWidth: CGFloat = 140
        static let retryButtonFrameHeight: CGFloat = 50
        static let retryButtonCornerRadius: CGFloat = 15
    }
    
    var action: (()->())?
    var title: String?
    var subtitle: String?
    var buttonText: String?
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                mainImage
                titleText
                subtitleText
                retryButton
                Spacer()
            }
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)

    }
    
    private var mainImage: some View {
        Image("error_robot_icon")
            .resizable()
            .frame(width: Constant.mainImageFrame, height: Constant.mainImageFrame)
            .padding(.top ,Constant.mainImagePadding)
    }
    
    private var titleText: some View {
        Text(title ?? "")
            .font(.title).bold()
            .multilineTextAlignment(.center)
            .padding(Constant.titleTextPadding)
            .foregroundColor(.black)
    }
    
    private var subtitleText: some View {
        Text(subtitle ?? "")
            .padding(.bottom, Constant.subtitleTextPadding)
            .font(.body)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray).opacity(Constant.subtitleTextForegroundColorOpacity)
    }
    
    private var retryButton: some View {
        Button(buttonText ?? "Try again") {
            action?()
        }
        .frame(width: Constant.retryButtonFrameWidth, height: Constant.retryButtonFrameHeight)
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(Constant.retryButtonCornerRadius)
        .font(.title)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(action: nil, title: "Uuups", subtitle: "There seems to be a connection problem")
    }
}

