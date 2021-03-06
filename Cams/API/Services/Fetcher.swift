//
//  Fetcher.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation

final class Fetcher {
    
    func fetchCameras (response: @escaping (CamerasResponse?) -> Void) {
        fetch(CamerasResponse.self, url: APIType.getCameras.request, response: response)
    }
    
    func fetchDoors (response: @escaping (DoorsResponse?) -> Void) {
        fetch(DoorsResponse.self, url: APIType.getDoors.request, response: response)
    }
    
    func fetchImage(url: URL,  completion: @escaping (Data) -> Void) {
        let image = Image.first(url: url.absoluteString)
        if let image = image { return completion(image.data) }
        
        Service.request(url: URLRequest(url: url)) { result in
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
    
    func fetch<T: Decodable>(_ T: T.Type, url: URLRequest, response: @escaping (T?) -> Void) {
        Service.request(url: url) { result in
            switch result {
            case .success(let data):
                response(Decoder.decode(T.self, data: data))
            case .failure(let error):
                print(error)
                response(nil)
            }
        }
    }
}
