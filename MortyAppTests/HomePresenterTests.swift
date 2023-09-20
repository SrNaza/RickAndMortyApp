//
//  HomePresenterTests.swift
//  MortyAppTests
//
//  Created by Nazareth Villalba on 19/09/23.
//

import XCTest
import RxSwift
import RxCocoa
@testable import MortyApp

class HomeFlowPresenterTests: XCTestCase {
    
    var homePresenter: HomeFlowPresenter!
    var interactorMock: HomeFlowInteractorMock!
    var routerMock: HomeFlowRouterMock!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        disposeBag = DisposeBag()
        
        // Crear mocks para el interactor y el router
        interactorMock = HomeFlowInteractorMock()
        routerMock = HomeFlowRouterMock(baseController: UIViewController())
        
        // Crear el presentador con los mocks
        homePresenter = HomeFlowPresenter(interactor: interactorMock, router: routerMock)
    }

    override func tearDownWithError() throws {
        disposeBag = nil
        homePresenter = nil
        interactorMock = nil
        routerMock = nil
        try super.tearDownWithError()
    }
    
    
    func testGetCharacterFailure() {
        interactorMock.characterToReturn = nil
        
        let observable = homePresenter.getCharacter(characterToSearch: "asdadw")
        
        let expectation = self.expectation(description: "Character search failed")
        var errorOccurred = false
        
        observable.subscribe(onError: { _ in
            errorOccurred = true
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(errorOccurred, "Expected an error but none occurred")
    }
    
    func testNotifyTransition() {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        let url = URL(string: urlString)!
        
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = URLSession.shared.dataTask(with: url) { _, response, error in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }
    
}
