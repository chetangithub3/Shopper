//
//  ImageLoader.swift
//  ShoppersStop
//
//  Created by Chetan Dhowlaghar on 4/29/24.
//

import Foundation
import UIKit

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from url: URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            image = UIImage(data: data)
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            image = UIImage(systemName: "exclamationmark.triangle")
        }
    }
}
