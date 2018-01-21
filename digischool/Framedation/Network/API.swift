//
//  API.swift
//  digischool
//
//  Created by Flavien SICARD on 1/21/18.
//  Copyright © 2018 Flavien SICARD. All rights reserved.
//

import Foundation
import Alamofire

protocol APIProtocol {
    var Request: API.request { get }
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

class API: NSObject {
    
    private let headers = ["Content-Type": "application/json; charset=utf-8"]
    
    struct request {
        var url: String
        var method: HTTPMethod
    }
    
    private func valueForAPIKey(named keyname:String) -> String {
        let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
    
    public func req(_ Req: requestEnum,
                    params: [String: String]? = nil,
                    completion: @escaping (_ success: Bool, _ data: Data?) -> ()) {
        
        var parameters: [String: String] = [:]
        if let params = params {
            parameters = params
        }
        parameters.update(other: ["apikey": valueForAPIKey(named: "APIKEY_PROD")])
        print(parameters)
        
        Alamofire.request(
            valueForAPIKey(named: "URL_PROD") + Req.Request.url,
            method: Req.Request.method,
            parameters: parameters,
            headers: headers)
            
            .response { response in
                switch response.response?.statusCode ?? 404 {
                case 200..<300:
                    completion(true, response.data)
                case 400..<500:
                    completion(false, response.data)
                default:
                    break
                }
        }
    }
    
    public enum requestEnum : APIProtocol {
        case getSearch
        
        var Request : request {
            switch self {
            case .getSearch:
                return request(url: "/", method: .get)
            }
        }
    }
    
}

