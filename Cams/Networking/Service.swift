//
//  Service.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation
import RealmSwift

final class Service {
    static func loadImage(url: URL,  completion: @escaping (Data) -> Void) {
        let image = Image.first(url: url.absoluteString)
        if let image = image {
            completion(image.data)
            print("FOUNDED")
        } else {
            Service.request(url: url) { result in
                switch result {
                case .success(let data):
                    let image = Image(url: url.absoluteString, data: data)
                    image.save()
                    completion(data)
                case .failure(_):
                    print("Failed to load image")
                }
            }
        }
    }
    
    static func request(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        print(url.absoluteString)
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
