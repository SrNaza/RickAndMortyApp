//
//  HomeFlowInteractor.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import RxSwift
import RxCocoa
import Alamofire
import AlamofireObjectMapper

protocol HomeFlowInteractorProtocol {
    func getCharacter(characterToSearch: String) -> Single<HomeCharacterSearch>
    func getAllCharacterInfo() -> Single<HomeCharacterSearch>
}

// MARK: - Home Interactive Implementation
class HomeFlowInteractor: HomeFlowInteractorProtocol {

    // MARK: - Life Cycle
    init() {}
    
    func getCharacter(characterToSearch: String) -> Single<HomeCharacterSearch> {
        
        let url = Api().formatterUrl(characterToSearch: characterToSearch)
        return Single<HomeCharacterSearch>.create { single in
            AF.request(url).responseDecodable(of: HomeCharacterSearch.self) { response in
                switch response.result {
                case .success(let result):
                    single(.success(result))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func getAllCharacterInfo() -> Single<HomeCharacterSearch> {
        
        let url = Api().urlAllCharacters
        return Single<HomeCharacterSearch>.create { single in
            AF.request(url).responseDecodable(of: HomeCharacterSearch.self) { response in
                switch response.result {
                case .success(let result):
                    single(.success(result))
                case .failure(let error):
                    print(error.errorDescription ?? "")
                }
            }
            return Disposables.create()
        }
    }
}
