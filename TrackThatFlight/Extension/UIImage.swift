//
//  UIImage.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 08/03/24.
//

import Foundation
import UIKit
import SVGKit

extension UIImage {
    static func downloadedsvg(from url: URL, completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
            else { return }
            DispatchQueue.main.sync() {
                completion(image)
            }
        }.resume()
    }
}

