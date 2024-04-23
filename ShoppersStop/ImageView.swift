//
//  ImageView.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/22/24.
//

import Foundation
import UIKit
import SwiftUI
struct ImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURLString: String
    
    var body: some View {
            VStack {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                loadImage()
            }
        }
        
        func loadImage() {
            guard let imageURL =  URL(string: imageURLString) else {
                return
            }
            Task {
                await imageLoader.loadImage(from: imageURL)
            }
        }

}

@MainActor
class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?

    func loadImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            image = UIImage(data: data)
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            image = nil
        }
    }
}
