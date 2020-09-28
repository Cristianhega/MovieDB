//
//  SharedObjects.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD

class SharedObjects {
    
    static func alertNoInternet(view: UIViewController, message:String! = ""){
        
        KRProgressHUD.dismiss()
        
        var messageNoInternet:String = ""
        
        if message! != ""{
            messageNoInternet = String(format: "%@. \n\nVerifica tu conexión a internet", message)
        }else{
            messageNoInternet = String(format: "Verifica tu conexión a internet")
        }
        
        let alert = UIAlertController(title: "Sin Internet", message: messageNoInternet, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        view.present(alert, animated: true)
    }
    
}
