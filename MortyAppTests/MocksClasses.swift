//
//  MocksClasses.swift
//  MortyAppTests
//
//  Created by Nazareth Villalba on 19/09/23.
//

import RxSwift
import RxCocoa
@testable import MortyApp

class HomeFlowInteractorMock: HomeFlowInteractorProtocol {
    
    var characterToReturn: HomeCharacterSearch?
    
    func getCharacter(characterToSearch: String) -> Single<HomeCharacterSearch> {
        if let character = characterToReturn {
            return Single.just(character)
        } else {
            return Single.error(NSError(domain: "TestError", code: 0, userInfo: nil))
        }
    }
    
    func getAllCharacterInfo() -> Single<HomeCharacterSearch> {
        return Single.just(HomeCharacterSearch(info: Info(count: 0, pages: 0, next: nil, prev: nil), results: []))
    }
}

class HomeFlowRouterMock: HomeFlowRouterProtocol {
    private weak var baseController: UIViewController?
    
    init(baseController: UIViewController) {
        self.baseController = baseController
    }
    
    var performedTransition: HomeFlowTransation?
    
    func performTransition(transition: HomeFlowTransation, onCompletion: RPCompletionBlock?) {
        performedTransition = transition
        onCompletion?()
    }
    
    func showItemsSearchDetail(item: MortyApp.Character) {
    }
    
    func showItemsCollection(infoResult: [MortyApp.Character], presenter: MortyApp.HomeFlowPresenterProtocol) {
    }
}

