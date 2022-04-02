//
//  Response.swift
//  Mobillium
//
//  Created by Cem Eke on 2.04.2022.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

class Response {
    func parseJSON<T:Codable>(response: AFDataResponse<Any>, model:T.Type, completion: @escaping (AFResult<Codable>) -> Void) {
        switch response.result {
        case .success(let value as [String: AnyObject]):
            do{
                let responseJsonData = JSON(value)
                let responseModel = try JSONDecoder().decode(model.self, from: responseJsonData.rawData())
                completion(.success(responseModel))
            }
            catch let parsingError{
                print("Success (error): \(parsingError)")
            }
            
        case .failure(let error):
            print("Failure: \(error)")
            completion(.failure(error))
            
        default: fatalError("Fatal error.")
            
        }
    }
}
