//
//  DetailRouter.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit

class DetailRouter: DetailRouterProtocol {

    class func createModule(detailRef: DetailView) {
        let presenter: DetailPresenterProtocol & DetailOutputInteractorProtocol = DetailPresenter()
        detailRef.presenter = presenter
        detailRef.presenter?.router = DetailRouter()
        detailRef.presenter?.view = detailRef
        detailRef.presenter?.interactor = DetailInteractor()
        detailRef.presenter?.interactor?.presenter = presenter
    }
    
}

