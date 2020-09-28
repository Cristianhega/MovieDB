//
//  ListInteractor.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import KRProgressHUD

class ListInteractor: ListInteractorProtocol {
    
    weak var presenter: ListOutputInteractorProtocol?
    
    var alamoFireManager : SessionManager?
    
    func getDataList(from view: UIViewController){
        
        let parameters: Parameters = [
            "api_key": Constants.apiKey
        ]
        
        let url = String(format: "%@%@", Constants.baseUrl, Urls.NOW_PLAYING.rawValue)
        
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
                        
                        if result != nil && result is NSDictionary {
                            let JSON = response.result.value as! NSDictionary
                            
                            if JSON["results"] != nil{
                                
                                let movies = Mapper<Movies>().map(JSONObject:response.result.value)
                                self.presenter?.receiveMovies(movies: (movies?.results)!)
                            }

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

