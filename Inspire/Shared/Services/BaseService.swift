//
//  BaseService.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

typealias JsonDictionay = [String : Any]

enum ServiceResponse {
    case success(code : Int, response: JsonDictionay)
    case failure
    case notConnectedToInternet
}

enum ResponseStatusCode: Int {
    case success = 200
}

class BaseService {
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var dataRequestArray: [DataRequest] = []
    var sessionManager: [String : Alamofire.SessionManager] = [:]
    var header : [String:String] = [:]
    
    func callEndPoint(endPoint: String, baseUrl : String? = AppConstants.baseUrl, method: Alamofire.HTTPMethod = .get, headers: [String:String]? = [:], params: JsonDictionay? = [:], completion: @escaping (ServiceResponse) -> Void){
        
        let url = (baseUrl! + endPoint).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let dataRequest: DataRequest?
        self.header = headers!
        self.header["authorization"] = AppConstants.apiKey
        self.header["Content-Type"] = "application/json"
        switch method {
        case .post:
            dataRequest = request(url!, method: method, parameters: params, encoding: JSONEncoding.default, headers: header).responseString { (response) in
                self.serializeResponse(response: response, completion: completion)
                self.sessionManager.removeValue(forKey: url!)
            }
        case .put:
            dataRequest = request(url!, method: method, parameters: params, encoding: JSONEncoding.default, headers: header).responseString { (response) in
                self.serializeResponse(response: response, completion: completion)
                self.sessionManager.removeValue(forKey: url!)
            }
        default:
            dataRequest = request(url!, method: method, parameters: params, headers: header).responseString { (response) in
                self.serializeResponse(response: response, completion: completion)
                self.sessionManager.removeValue(forKey: url!)
            }
        }
    }
    
    func serializeResponse(response: Alamofire.DataResponse<String>,  completion: @escaping (ServiceResponse) -> Void) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            var json: Any?
            guard let urlResponse = response.response else {
                if let error = response.result.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    strongSelf.notConnectedToInternet(completion: completion)
                } else {
                    print(">>>>>>>>>>>>>>>")
                    print(response.response?.statusCode as Any)
                    strongSelf.failure(completion: completion)
                }
                return
            }
            
            if let data = response.result.value?.data(using: String.Encoding.utf8) {
                do {
                    json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                } catch {
                    print(">>>>>>>>>>>>>>>")
                    print(response.response?.statusCode as Any)
                    strongSelf.failure(completion: completion)
                    return
                }
            }
            
            guard let jsonResponse = json as? JsonDictionay else {
                strongSelf.failure(completion: completion)
                return
            }
            print(jsonResponse)
            if jsonResponse["success"] as? Bool == false {
                print(">>>>>>>>>>>>>>>")
                print(response.response?.statusCode as Any)
                strongSelf.failure(completion: completion)
                return
            }
            
            strongSelf.success(code : (response.response?.statusCode)!, result:jsonResponse , headers: urlResponse.allHeaderFields, completion: completion)
        }
    }
    
    func cancelAllRequests () {
        for dataRequest in self.dataRequestArray {
            dataRequest.cancel()
        }
        self.dataRequestArray.removeAll()
    }
    
    func notConnectedToInternet (completion:@escaping (ServiceResponse) -> Void) {
        completion(.notConnectedToInternet)
    }
    
    func failure (completion:@escaping (ServiceResponse) -> Void) {
        completion(.failure)
    }
    
    func success (code : Int, result: JsonDictionay?, headers: [AnyHashable: Any], completion:@escaping (ServiceResponse) -> Void) {
        completion(.success(code : code, response: result!))
    }
}
