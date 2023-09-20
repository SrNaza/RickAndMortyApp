//
//  HomeViewController.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    // MARK: - Initialization
    @IBOutlet weak var searchBardField: UITextField! {
        didSet {
            searchBardField.rx.controlEvent([.editingDidEndOnExit])
                .asObservable()
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.sendInformation()
                })
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = Images.image(type: .logo)
        }
    }
    
    @IBOutlet weak var seeAllCharacterButton: UIButton!
    
    var presenter: HomeFlowPresenterProtocol?
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor: HomeFlowInteractorProtocol = HomeFlowInteractor()
        let router: HomeFlowRouterProtocol = HomeFlowRouter(baseController: self)
        presenter = HomeFlowPresenter(interactor: interactor, router: router)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    @IBAction func seeAllCharacterAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        
        let detailInfo = presenter.getAllCharacterInfo().asObservable()
        
        detailInfo.asObservable()
            .subscribe(onNext: { [weak self] info in
                guard let self = self, !info.results.isEmpty else {
                    return
                }
                self.presenter?.handleAction(.showList(item: info.results))
                
            }).disposed(by: disposeBag)
    }
}

extension HomeViewController {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchBardField.resignFirstResponder()
        return true
    }
    
    func setup() {
        searchBardField.text = ""
        searchBardField.textColor = .black
        searchBardField.placeholder = "Search Rick and Morty Character"
        searchBardField.setPlaceHolderColor()
        
        titleLabel.text = "Rick & Morty App 🫡"
        titleLabel.textColor = .black
        
        seeAllCharacterButton.backgroundColor = UIColor.white
        seeAllCharacterButton.setTitleColor(UIColor(red: 88, green: 86, blue: 214, alpha: 1.0), for: .normal)
        seeAllCharacterButton.layer.cornerRadius = 8.0
    }
    
    func sendInformation() {
        guard let presenter = presenter else { return }
        
        if searchBardField.text?.count == 0 {
            searchBardField.text = ""
            searchBardField.placeholder = "Search Rick and Morty Character"
            showOptionsAlert(title: "Empty Search", redButtonTitle: "Cancel", message: "You need to indicate an character to search for") { }
        }
        
        let detailInfo = presenter.getCharacter(characterToSearch: searchBardField.text ?? "").asObservable()
        
        detailInfo.asObservable()
            .subscribe(onNext: { [weak self] info in
                guard let self = self, !info.results.isEmpty else {
                    return
                }
                debugPrint("Showing data repose \(info)")
                self.presenter?.handleAction(.showList(item: info.results))
                
            },
            onError: { [weak self] _ in
                guard let self = self else { return }
                self.showOptionsAlert(title: "Wrong Character", redButtonTitle: "Cancel", message: "You need to indicate a valid character to search for") { }
            }).disposed(by: disposeBag)
    }
}

