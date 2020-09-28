//
//  DetailInteractor.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import KRProgressHUD

class DetailInteractor: DetailInteractorProtocol {
    
    weak var presenter: DetailOutputInteractorProtocol?
    
    var alamoFireManager : SessionManager?
    
    func getDetail(from view: UIViewController, movie: Results){
        
        let parameters: Parameters = [
            "api_key": Constants.apiKey
        ]
        
        let id = movie.id!
        let url = String(format: "%@%@%@", Constants.baseUrl, Urls.MOVIE_DETAILS.rawValue, "/\(id)")
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 6.0
        configuration.timeoutIntervalForResource = 6.0
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
        alamoFireManager!.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers
        )
            .responseJSON {
                response in
                switch (response.result) {
                case .success:
                    if response.response?.statusCode == 200 {
                        
                        KRProgressHUD.dismiss()
                        
                        let result = response.result.value
                        var details: Array<Detail> = []
                        
                        if result != nil && result is NSDictionary {
                            
                            let movieDetails = Mapper<Detail>().map(JSONObject:response.result.value)
                            details.append(movieDetails!)
                            self.presenter?.receiveDetail(detail: details)
                            
                        }
                        
                    } else {
                        KRProgressHUD.dismiss()
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    KRProgressHUD.dismiss()
                    break
                }
        }
    }
}

