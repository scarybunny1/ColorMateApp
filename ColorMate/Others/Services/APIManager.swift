//
//  APIManager.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 20/06/23.
//

import Foundation

enum CMAPIError: Error{
    case failedToFetch
}

class APIManager{
    private init(){}
    
    static let shared = APIManager()
    
    func checkColor(color: RGBA, completion: @escaping (Result<CMColorResponse, Error>) -> Void){
        let rgb_value = "\(color.red),\(color.green),\(color.blue)"
        let request = CMColorRequest(queryParams: [URLQueryItem(name: "rgb", value: rgb_value)], path: "id")
        guard let url = request.url else{return}
        URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
            guard let data = data, error == nil else{
                completion(.failure(CMAPIError.failedToFetch))
                return
            }
            
            do{
                let json = try JSONDecoder().decode(CMColorResponse.self, from: data)
                completion(.success(json))
            }catch{
                print(error)
            }
        }.resume()
    }
}
