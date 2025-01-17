//
//  LoaderView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct LoaderView: View {
    
    private enum Constants {
        static let circleStrokeStyleLineWidth: CGFloat = 8.0
        static let circleFrame: CGFloat = 60
        static let circleAnimationEaseInDuration: CGFloat = 1.5
        static let circleAnimationLinearDuration: CGFloat = 1.0
        static let fullCircleDegrees: Int = 360
    }
    
    @State private var degree: Int = 270
    @State private var spinnerLength = 0.6
    
    var body: some View {
        Circle()
            .trim(from: .zero,to: spinnerLength)
            .stroke(LinearGradient(colors: [.red,.blue], startPoint: .topLeading, endPoint: .bottomTrailing),style: StrokeStyle(lineWidth: Constants.circleStrokeStyleLineWidth,lineCap: .round,lineJoin:.round))
            .animation(Animation.easeIn(duration: Constants.circleAnimationEaseInDuration).repeatForever(autoreverses: true), value: degree)
            .frame(width: Constants.circleFrame,height: Constants.circleFrame)
            .rotationEffect(Angle(degrees: Double(degree)))
            .animation(Animation.linear(duration: Constants.circleAnimationLinearDuration).repeatForever(autoreverses: false), value: degree)
            .onAppear{
                degree += Constants.fullCircleDegrees
                spinnerLength = .zero
            }
    }
}

#Preview {
    LoaderView()
}

