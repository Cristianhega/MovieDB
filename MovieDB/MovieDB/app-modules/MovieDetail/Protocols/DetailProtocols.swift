//
//  DetailProtocols.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit

protocol DetailViewProtocol: class {
    // PRESENTER -> VIEW
    func receiveDetail(detail: [Detail])
}

protocol DetailPresenterProtocol: class {
    //View -> Presenter
    var interactor: DetailInteractorProtocol? {get set}
    var view: DetailViewProtocol? {get set}
    var router: DetailRouterProtocol? {get set}
    
    func viewDidLoad()
    func getData(movie: Results)
}

protocol DetailInteractorProtocol: class {
    var presenter: DetailOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func getDetail(from view: UIViewController, movie: Results)
}

protocol DetailOutputInteractorProtocol: class {
    //Interactor -> PresenterOutput
    func receiveDetail(detail: [Detail])
}

protocol DetailRouterProtocol: class {
    //Presenter -> Wireframe
    static func createModule(detailRef: DetailView)
}

