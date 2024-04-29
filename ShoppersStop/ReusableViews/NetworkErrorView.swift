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
            Spacer()
            HStack{
             Spacer()
                Image(systemName: "network.slash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.primary)
                Spacer()
            }
           
            
            Text("No internet connection")
                .font(.title)
                .foregroundColor(.primary)
                .padding()
            
            Text("Please check your connection and try again.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
        }
        .background(Color.white.opacity(0.7))
        .ignoresSafeArea()
    }
}

#Preview {
    NetworkErrorView()
}

