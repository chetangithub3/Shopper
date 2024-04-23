//
//  NetworkErrorView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import SwiftUI

struct NetworkErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "network.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.primary)
            
            Text("No internet connection")
                .font(.title)
                .foregroundColor(.primary)
                .padding()
            
            Text("Please check your connection and try again.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    NetworkErrorView()
}

