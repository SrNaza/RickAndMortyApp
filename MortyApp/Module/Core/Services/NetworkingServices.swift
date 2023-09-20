//
//  NetworkingServices.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import ObjectMapper

let baseURL = "https://rickandmortyapi.com/api"

class ApiError : NSObject, Mappable {
    
    var message: String!
    
    required init?(map: Map) { }
    
    override init() { }
    
    func mapping(map: Map) {
        self.message <- map["message"]
    }
}

public class Api {
    
    required init() {}
    
    func formatterUrl(characterToSearch: String) -> String {
        var path: String = ""
        
        if let validText = characterToSearch.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]{} ").inverted){
            path = "\(baseURL)/character/?name=\(validText)"
        } else {
            path = "\(baseURL)/character/?name=\(characterToSearch)"
        }
        
        return path
    }
    
    let urlAllCharacters = "\(baseURL)/character"
}
