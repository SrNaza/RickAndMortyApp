//
//  HomeFlowRouter.swift
//  MortyApp
//
//  Created by Eduardo Marquez on 19/09/23.
//

import UIKit
import RxSwift
import RxCocoa

enum HomeFlowTransation {
    case showItemsSearchDetail(item: Character)
    case showItemsCollection(infoResult: [Character], presenter: HomeFlowPresenterProtocol)
}

// MARK: - Home Interactive Implementation
class HomeFlowRouter {

    // MARK: - Life Cycle
    private weak var baseController: UIViewController?
    private weak var shareModalController: UIViewController?

    init(baseController: UIViewController) {
        self.baseController = baseController
    }
    
    func performTransition(transition: HomeFlowTransation, onCompletion completion: RPCompletionBlock?) {
        switch transition {
        case .showItemsSearchDetail(let item):
            showItemsSearchDetail(item: item)
            debugPrint("Tring to show Item search")
        case .showItemsCollection(let infoResult, let presenter):
            showItemsCollection(infoResult: infoResult, presenter: presenter)
            debugPrint("Tring to show Collection")
        }
    }
}

extension HomeFlowRouter {
    func showItemsSearchDetail(item: Character) {
        let viewController = DetailViewController2(result: item)
        baseController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showItemsCollection(infoResult: [Character], presenter: HomeFlowPresenterProtocol) {
        let viewController = ListSectionViewController(result: infoResult, presenter: presenter)
        baseController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
