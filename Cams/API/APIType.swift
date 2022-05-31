//
//  APIManager.swift
//  Cams
//
//  Created by CPRO GROUP on 31.05.2022.
//

import Foundation

enum APIType {
    
    case getCameras
    case getDoors
    
    var baseURL: String { "http://cars.cprogroup.ru/api/rubetek/" }
    
    var path: String {
        switch self {
        case .getCameras: return "cameras"
        case .getDoors: return "doors"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)
        let request = URLRequest(url: url!)
        return request
    }
    
}
