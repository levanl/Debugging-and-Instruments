//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded)) }
            } catch let error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
        }.resume()
    }
}



enum NetworkError: Error {
    case invalidURL
    case emptyData
}
