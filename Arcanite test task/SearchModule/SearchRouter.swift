//
//  SearchRouter.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import Foundation
import UIKit

protocol SearchRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func presentPlayer(from view: SearchViewProtocol, for song: Song)
}

class SearchRouter: SearchRouterProtocol {
    static func createModule() -> UIViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
// Route to player
    func presentPlayer(from view: SearchViewProtocol, for song: Song) {
        let playerViewController = PlayerRouter.createModule(with: song)

        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(playerViewController, animated: true)
        }
    }
}
