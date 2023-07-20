//
//  CMColorRequest.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 20/06/23.
//

import Foundation

enum CMHTTPMethod: String{
    case get = "GET"
    case post = "POST"
}

struct CMColorRequest{
    let baseUrl = "https://www.thecolorapi.com"
    
    var queryParams: [URLQueryItem]
    var path: String
    
    var urlString: String{
        var string = baseUrl
        string += path
        
        if queryParams.count > 0{
            string += "?"
        }
        let queryArguments = queryParams.compactMap { (item: URLQueryItem) -> String? in
            guard let value = item.value else{return nil}
            return "\(item.name)=\(value)"
        }
        string += queryArguments.joined(separator: "&")
        
        return string
    }
    
    var url: URL?{
        if let url = URL(string: urlString){
            return url
        }
        else{
            return nil
        }
    }
}
