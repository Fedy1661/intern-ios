//
//  Fetcher.swift
//  Cams
//
//  Created by Fedor Konovalov on 23.05.2022.
//

import Foundation

final class Fetcher {
    
    private let camerasUrl = URL(string: "http://cars.cprogroup.ru/api/rubetek/cameras/")!
    private let doorsUrl = URL(string: "http://cars.cprogroup.ru/api/rubetek/doors/")!
    
    func fetchCameras (response: @escaping (CamerasResponse?) -> Void) {
        fetch(CamerasResponse.self, url: APIType.getCameras.request, response: response)
    }
    
    func fetchDoors (response: @escaping (DoorsResponse?) -> Void) {
        fetch(DoorsResponse.self, url: APIType.getDoors.request, response: response)
    }
    
    func fetch<T: Decodable>(_ T: T.Type, url: URLRequest, response: @escaping (T?) -> Void) {
        Service.request(url: url) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                response(self.decode(T.self, data: data))
            case .failure(let error):
                print(error)
                response(nil)
            }
        }
    }
    
    private func decode<T: Decodable>(_ T: T.Type, data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let jsonError {
            print(jsonError)
            return nil
        }
    }
}
