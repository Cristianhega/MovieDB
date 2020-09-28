//
//  DetailPresenter.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit
import KRProgressHUD

class DetailPresenter: DetailPresenterProtocol {
    
    var router: DetailRouterProtocol?
    var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var presenter: DetailPresenterProtocol?
    
    func viewDidLoad() {
        
    }
    
    func getData(movie: Results){
        KRProgressHUD.show()
        
        if Reachability.isConnectedToNetwork(){
            interactor?.getDetail(from: view as! UIViewController, movie: movie)
        } else {
            SharedObjects.alertNoInternet(view: view as! UIViewController)
        }
    }
}

extension DetailPresenter: DetailOutputInteractorProtocol {
    func receiveDetail(detail: [Detail]){
        KRProgressHUD.dismiss()
        view?.receiveDetail(detail: detail)
    }
}
