//
//  NetworkService.swift
//  ElonDream
//
//  Created by Вякулин Сергей on 13.09.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getRequest<T: Codable>(type: T.Type, urlString: String, param: String, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private func sendGetRequest(urlString: String, param: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: "\(urlString)\(param)") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.sync {
                completion(data,error)
            }
        }.resume()
    }
    
    func getRequest<T: Codable>(type: T.Type, urlString: String, param: String, completion: @escaping (Result<T, Error>) -> Void){
        sendGetRequest(urlString: urlString, param: param) { data, error in
            if let error = error {
                completion(Result.failure(error))
            }
            
            guard let data = data else {return}
            let decoder = JSONDecoder()
            let results: T = try! decoder.decode(T.self, from: data)
            completion(Result.success(results))
        }
    }
    
    
}
