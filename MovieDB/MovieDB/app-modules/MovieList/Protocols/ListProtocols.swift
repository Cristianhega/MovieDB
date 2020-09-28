//
//  ListProtocols.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit

protocol ListViewProtocol: class {
    // PRESENTER -> VIEW
    func receiveMovies(movies: [Results])
}

protocol ListPresenterProtocol: class {
    //View -> Presenter
    var interactor: ListInteractorProtocol? {get set}
    var view: ListViewProtocol? {get set}
    var router: ListRouterProtocol? {get set}
    
    func viewDidLoad()
    func getData()
    func goToDetail(movie: Results)
}

protocol ListInteractorProtocol: class {
    var presenter: ListOutputInteractorProtocol? {get set}
    //Presenter -> Interactor
    func getDataList(from view: UIViewController)
}

protocol ListOutputInteractorProtocol: class {
    //Interactor -> PresenterOutput
    func receiveMovies(movies: [Results])
}

protocol ListRouterProtocol: class {
    //Presenter -> Wireframe
    static func createModule(listRef: ListView)
    func pushToDetail(from view: UIViewController, movie: Results)
}

