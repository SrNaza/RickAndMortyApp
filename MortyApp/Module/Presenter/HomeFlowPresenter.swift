//
//  HomeFlowPresenter.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Home Module Presentable Implementation
public typealias RPCompletionBlock = () -> Void

class HomeFlowPresenter {
    // MARK: - Properties
    private let interactor: HomeFlowInteractorProtocol
    private let router: HomeFlowRouterProtocol
    private let disposeBag = DisposeBag()
    

    // MARK: - Life Cycle
    required init(interactor: HomeFlowInteractorProtocol, router: HomeFlowRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomeFlowPresenter: HomeFlowPresenterProtocol {
    
    func notifyTransition(transition: HomeFlowTransation, completion: RPCompletionBlock? = nil) {
        router.performTransition(transition: transition, onCompletion: completion)
    }
    
    func getCharacter(characterToSearch: String) -> Observable<HomeCharacterSearch> {
        return interactor.getCharacter(characterToSearch: characterToSearch)
            .asObservable()
    }
    
    func getAllCharacterInfo() -> Observable<HomeCharacterSearch> {
        return interactor.getAllCharacterInfo()
            .asObservable()
    }
    
    func handleAction(_ action: HomePresenterAction) {
        switch action {
        case .showDetail(let item):
            router.performTransition(transition: .showItemsSearchDetail(item: item), onCompletion: nil)
        case .showList(let itemList):
            router.performTransition(transition: .showItemsCollection(infoResult: itemList, presenter: self), onCompletion: nil)
        }
    }
}
