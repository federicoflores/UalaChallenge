//
//  View+Extensions.swift
//  UalaChallenge
//
//  Created by Fede Flores on 17/01/2025.
//

import SwiftUI

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
