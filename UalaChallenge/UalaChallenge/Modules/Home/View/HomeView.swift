//
//  HomeView.swift
//  UalaChallenge
//
//  Created by Fede Flores on 16/01/2025.
//

import SwiftUI

struct HomeView: View {
    let provider: NetworkProvider = NetworkProvider()
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .task {
            do {
                let test: [UalaPlace] = try await provider.getDecodable()
                let _ = print("Success")
            } catch {
                let _ = print("Failure")
                let _ = print(error.localizedDescription)
            }
        }
    }
        
    
}

#Preview {
    HomeView()
}
