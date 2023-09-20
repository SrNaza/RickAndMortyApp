//
//  HomeFlowPresenterProtocol.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import RxSwift
import RxCocoa

protocol HomeFlowPresenterProtocol {
    func getCharacter(characterToSearch: String) -> Observable<HomeCharacterSearch>
    func getAllCharacterInfo() -> Observable<HomeCharacterSearch>
    func notifyTransition(transition: HomeFlowTransation, completion: RPCompletionBlock?)
    func handleAction(_ action: HomePresenterAction)
}

enum HomePresenterAction {
    case showDetail(item: Character)
    case showList(item: [Character])
}
