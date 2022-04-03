//
//  NetworkManager.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation

import Foundation
import Alamofire
import UIKit

class NetworkManager {
    
    static let instance = NetworkManager()
    private let parse = Response()
    
    let headers : HTTPHeaders = [
        "Accept": "*/*",
        "User-Agent": "Mozilla/5.0 (compatible; Rigor/1.0.0; http://rigor.com)"
    ]
    
    public func fetch<T:Codable> (_ method: HTTPMethod, url: String, params: Parameters?, model: T.Type, completion: @escaping (AFResult<Codable>) -> Void)
    {
        AF.request(
            url,
            method: method,
            //parameters: NetworkManager.toParameters(model: requestModel),
            parameters: params,
            encoding: URLEncoding.queryString,
            headers: headers
        )
            .validate()
            .responseJSON { [weak self] response in
                self?.parse.parseJSON(response: response, model: model, completion: completion)
            }
    }
    
}

extension NetworkManager {
    static func toParameters<T:Encodable>(model: T?) -> [String:AnyObject]?
    {
        if(model == nil)
        {
            return nil
        }
        
        let jsonData = modelToJson(model:model)
        let parameters = jsonToParameters(from: jsonData!)
        return parameters! as [String: AnyObject]
    }
    
    static func modelToJson<T:Encodable>(model:T)  -> Data?
    {
        return try! JSONEncoder().encode(model.self)
    }


    static func jsonToParameters(from data: Data) -> [String: Any]?
    {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}
