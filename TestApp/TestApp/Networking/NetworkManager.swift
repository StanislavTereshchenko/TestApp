//
//  NetworkManager.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//
import Alamofire
import Foundation

class NetworkManager {
    static func fetchLocationData(completion: @escaping (Result<LocationData, Error>) -> Void) {
        let apiUrl = "http://ip-api.com/json"
        AF.request(apiUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any], let locationData = LocationData(json: json) {
                    completion(.success(locationData))
                } else {
                    let error = NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error parsing JSON"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
