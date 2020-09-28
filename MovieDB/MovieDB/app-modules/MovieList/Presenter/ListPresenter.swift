//
//  ListPresenter.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit
import KRProgressHUD

class ListPresenter: ListPresenterProtocol {
    
    var router: ListRouterProtocol?
    var view: ListViewProtocol?
    var interactor: ListInteractorProtocol?
    var presenter: ListPresenterProtocol?
    
    func viewDidLoad() {
        
    }
    
    func getData(){
        KRProgressHUD.show()
        if Reachability.isConnectedToNetwork(){
            interactor?.getDataList(from: view as! UIViewController)
        } else {
            SharedObjects.alertNoInternet(view: view as! UIViewController)
        }
    }
    
    func goToDetail(movie: Results) {
        router?.pushToDetail(from: view as! UIViewController, movie: movie)
    }
    
}

extension ListPresenter: ListOutputInteractorProtocol {
    func receiveMovies(movies: [Results]){
        KRProgressHUD.dismiss()
        view?.receiveMovies(movies: movies)
    }
}
