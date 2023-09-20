//
//  MortyAppTests.swift
//  MortyAppTests
//
//  Created by Nazareth Villalba on 19/09/23.
//

import XCTest
import RxSwift
import RxCocoa
@testable import MortyApp

final class MortyAppTests: XCTestCase {

    var homePresenter: HomeFlowPresenterProtocol!
    var urlSession: URLSession!
    var disposeBag = DisposeBag()

    override func setUpWithError() throws {
        try super.setUpWithError()
        homePresenter = HomeFlowPresenter(interactor: HomeFlowInteractor(), router: HomeFlowRouter(baseController: UIViewController()))
        urlSession = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        homePresenter = nil
        urlSession = nil
        try super.tearDownWithError()
    }
    
    func testSeacrhTextFieldIsEmpty() {
        let transitionExpectation = expectation(description: "Should get search done")
        
        let characterInfo = homePresenter?.getCharacter(characterToSearch: "rick")
            .asObservable()
        
        characterInfo?.asObservable()
            .take(1)
            .subscribe(onNext: { info in
                XCTAssertEqual(!info.results.isEmpty, true, "Textfield shouldn't be empty")
                transitionExpectation.fulfill()
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5) {
            print($0?.localizedDescription ?? "Error waiting expectation")
        }
    }
    
    func testNotifyTransition() {
        let transitionExpectation = expectation(description: "should transation done")
        
        let characterInfo = homePresenter?.getCharacter(characterToSearch: "rick")
            .asObservable()
        
        characterInfo?.asObservable()
            .take(1)
            .subscribe(onNext: { [weak self] info in
                guard let self = self, let infoResult = info.results.first else { return }
                
                self.homePresenter.notifyTransition(transition: .showItemsSearchDetail(item: infoResult), completion: {
                    print("Trying to show something")
                })
                
                transitionExpectation.fulfill()
        }).disposed(by: disposeBag)
    
        
        waitForExpectations(timeout: 5) {
            print($0?.localizedDescription ?? "Error waiting expectation")
        }
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
      
      let urlString = "https://rickandmortyapi.com/api/character"
        
      let url = URL(string: urlString)!
      
      let promise = expectation(description: "Status code: 200")
      
      let dataTask = urlSession.dataTask(with: url) { _, response, error in
        
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
