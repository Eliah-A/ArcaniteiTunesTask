//
//  PlayerRouter.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 02.06.2023.
//

import Foundation
import UIKit

protocol PlayerRouterProtocol: AnyObject {
    static func createModule(with song: Song) -> UIViewController
}

class PlayerRouter: PlayerRouterProtocol {
    static func createModule(with song: Song) -> UIViewController {
        let view = PlayerViewController()
        let interactor = PlayerInteractor()
        let router = PlayerRouter()
        let presenter = PlayerPresenter(song: song)

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor

        return view
    }
}
