//
//  ImageLoaderService.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation
import UIKit

class ImageLoaderService {
    static let shared = ImageLoaderService()

    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
