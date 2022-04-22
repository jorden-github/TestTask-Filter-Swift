//
//  NetworkManager.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//

import Foundation
#if !os(iOS)
import AppKit
#endif
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class NetworkManager: NSObject {
    
    var manager: Session!
    static var alamofireManager = NetworkManager.init()
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        manager = Alamofire.Session(configuration: configuration)
    }
    class func apiCommunicationWithMapping<T:Decodable>(
        _apiMethod:CallingMethod,
        _mapperClass:T.Type,
        _url:String,
        _parameters:[String:Any]?
        ,headerParam:Bool = false,
         encoding:ParameterEncoding = JSONEncoding.default,
         successHandler:(( _ response: HTTPURLResponse?,  _ result:T?) -> Void)!
        ,failure: (( _ error: NSError?) -> Void)!) -> Void {
        
        
        AF.request(_url, method: _apiMethod.restMethods, parameters: _parameters, encoding:encoding, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                let JSON = value  as! NSArray
                let jsonObject = JSON as AnyObject
                // 1
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                    
                    let mappedObj = try decoder.decode(_mapperClass, from: jsonData)
                    successHandler?(response.response,mappedObj)
                }catch {
                    failure?(error as NSError?)
                }
                break
            case .failure(let error):
                
                print(error)
                failure?(error as NSError?)
            }
        }
        
    }
}
enum CallingMethod {
    
    case get
    var restMethods: Alamofire.HTTPMethod {
        var calledMethod: Alamofire.HTTPMethod
        switch self {
        case .get:
            calledMethod = .get
            return calledMethod
        }
    }
}
