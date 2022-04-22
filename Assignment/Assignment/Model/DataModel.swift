//
//  DataModel.swift
//  Assignment
//
//  Created by Jorden Williams on 22/04/2022.
//


import Foundation
import Alamofire

// MARK: - WelcomeElement
class DataModel: Codable {
    let charID: Int
    let name: String
    let birthday: String
    let occupation: [String]
    let img: String
    let status: String
    let nickname: String
    let appearance: [Int]
    let portrayed: String
    let category: Category
    let betterCallSaulAppearance: [Int]

    enum CodingKeys: String, CodingKey {
        case charID = "char_id"
        case name, birthday, occupation, img, status, nickname, appearance, portrayed, category
        case betterCallSaulAppearance = "better_call_saul_appearance"
    }

    init(charID: Int, name: String, birthday: String, occupation: [String], img: String, status: String, nickname: String, appearance: [Int], portrayed: String, category: Category, betterCallSaulAppearance: [Int]) {
        self.charID = charID
        self.name = name
        self.birthday = birthday
        self.occupation = occupation
        self.img = img
        self.status = status
        self.nickname = nickname
        self.appearance = appearance
        self.portrayed = portrayed
        self.category = category
        self.betterCallSaulAppearance = betterCallSaulAppearance
    }
    
    class func getAllCustomers ( successHandler:((_ result: [DataModel]) -> Void)!,failure: ((_ error: String?) -> Void)!){
            let dict : [String : Any] = [
                
                "char_id": 1,
                "name": "Walter White",
                "birthday": "09-07-1958",
                "occupation": [
                "High School Chemistry Teacher",
                "Meth King Pin"
                ],
                "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
                "status": "Presumed dead",
                "nickname": "Heisenberg",
                "appearance": [
                1,
                2,
                3,
                4,
                5
                ],
                "portrayed": "Bryan Cranston",
                "category": "Breaking Bad",
                "better_call_saul_appearance": []
                
                ]
            
            // 2- Convert to Json data
            
            let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue )
            
            let param : [String : Any] = ["" : jsonString!]
            
            
            // 3- Make a request
            NetworkManager.apiCommunicationWithMapping(
                _apiMethod: .get,
                _mapperClass: [DataModel].self,
                _url: "https://breakingbadapi.com/api/characters",
                _parameters: param,
                headerParam:false,
                encoding:URLEncoding.default,
                successHandler: { (httpResponse, customerResponse) in
                    
                    
                    guard let customerResponse = customerResponse else {
                        print("Response is nil")
                        failure(nil)
                        return
                    }
                    successHandler(customerResponse)
                    print(customerResponse)
                    
            }) { (err) in
                print(err ?? "not found any right error")
                failure(err?.localizedDescription)
            }
        
    }
    
    
    
    
}

enum Birthday: String, Codable {
    case the07081993 = "07-08-1993"
    case the08111970 = "08-11-1970"
    case the09071958 = "09-07-1958"
    case the09241984 = "09-24-1984"
    case unknown = "Unknown"
}

enum Category: String, Codable {
    case betterCallSaul = "Better Call Saul"
    case breakingBad = "Breaking Bad"
    case breakingBadBetterCallSaul = "Breaking Bad, Better Call Saul"
}

enum Status: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}
