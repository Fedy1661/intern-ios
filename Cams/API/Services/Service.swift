//
//  Service.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation
import RealmSwift

final class Service {
    static func request(url: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
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
