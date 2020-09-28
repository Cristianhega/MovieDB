//
//  ListRouter.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit


class ListRouter: ListRouterProtocol {

    class func createModule(listRef: ListView) {
        let presenter: ListPresenterProtocol & ListOutputInteractorProtocol = ListPresenter()
        listRef.presenter = presenter
        listRef.presenter?.router = ListRouter()
        listRef.presenter?.view = listRef
        listRef.presenter?.interactor = ListInteractor()
        listRef.presenter?.interactor?.presenter = presenter
    }
    
    func pushToDetail(from view: UIViewController, movie: Results) {
        let detailViewController = view.storyboard?.instantiateViewController(withIdentifier: "detailID") as! DetailView
        detailViewController.movie = movie
        view.navigationController?.pushViewController(detailViewController, animated: false)
        
    }
}

