//
//  NetworkCall.swift
//  TrackThatFlight
//
//  Created by Kapil Shanbhag on 17/02/24.
//

import Foundation

class NetworkCall {
    class func loadRequest<R: Codable>(_ type: R.Type, request: NetworkRequest, completion: @escaping (R?, NetworkError?) -> Void) {
        
        guard var url = URL(string: request.baseURL+request.endPoint+addParams(params: request.queryParams)) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue.uppercased()
       
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let response = urlResponse as? HTTPURLResponse, response.statusCode > 400 {
                completion(nil, NetworkError(code: response.statusCode, errorMsg: "Something went wrong"))
            }
            guard let data = data else {return}
            do {
                let resp: R = try JSONDecoder().decode(R.self, from: data)
                completion(resp, nil)
            }
            catch {
                completion(nil, NetworkError(code: 0, errorMsg: "Something went wrong"))
            }
            
        }.resume()
    }
    
    class func addParams(params: [String : Any]) -> String {
        if params.isEmpty {return ""}
        var url = "?"
        for (key, val) in params {
            url += "\(key)=\(val)&"
        }
        
        url.removeLast()
        
        return url
    }
}
