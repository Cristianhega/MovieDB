//
//  DetailView.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit
import SDWebImage
import KRProgressHUD

class DetailView: UIViewController, DetailViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var presenter:DetailPresenterProtocol?
    
    var movie:Results? = nil
    var detailMovie: Array<Detail> = []
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var collectionDetail: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configVIPER()
        configUI()
    }
    
    func configVIPER(){
        DetailRouter.createModule(detailRef: self)
        presenter?.viewDidLoad()
        
        getMovieDetail()
    }
        
    func configUI(){
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionDetail.alwaysBounceVertical = true
        collectionDetail.refreshControl = refreshControl
        
        collectionDetail.delegate = self
        collectionDetail.dataSource = self
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        getMovieDetail()
        refreshControl.endRefreshing()
    }
    
    func getMovieDetail(){
        refreshControl.endRefreshing()
        
        if Reachability.isConnectedToNetwork(){
            self.presenter?.getData(movie: movie!)
        } else {
            KRProgressHUD.dismiss()
            
            let alertController = UIAlertController(title: "Verifica tu conexión a internet", message: "", preferredStyle: .alert)

            let tryAgain = UIAlertAction(title: "Intentar de nuevo", style: .default, handler: { alert -> Void in
                self.presenter?.getData(movie: self.movie!)
            })

            let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: { alert -> Void in
                self.dismiss(animated: true, completion: nil)
            })

            alertController.addAction(tryAgain)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }
        
    func receiveDetail(detail: [Detail]){
        
        detailMovie = detail
        collectionDetail.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionDetail.frame.size.width, height: collectionDetail.frame.size.height)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailMovie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDetail", for: indexPath) as! CellDetail
        
        cell.textTitle.text = (detailMovie[indexPath.item].title)!
        let date = String(format: "%@%@", String((detailMovie[indexPath.item].runtime)!), " min")
        cell.textTime.text = date
        cell.textRelease.text = changeDate(string: (detailMovie[indexPath.item].release_date)!)
        
        let votes: String = String(format: "%.1f", (detailMovie[indexPath.item].vote_average)!)
        cell.textScore.text = votes
        
        for i in 0...detailMovie[indexPath.row].genres!.count - 1{
            var string = ""
            if i != detailMovie[indexPath.row].genres!.count - 1{
                string = (detailMovie[indexPath.row].genres?[i].name)! + ", "
            } else {
                string = (detailMovie[indexPath.row].genres?[i].name)!
            }
            
            cell.textGenders.text?.append(string)
        }
        
        let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont(name:"avenir", size: 15.0)
        l.lineBreakMode = .byWordWrapping
        l.text = detailMovie[indexPath.item].overview!
        l.frame.size.width = collectionDetail.frame.size.width - 40
        l.frame.origin.x = 20
        l.frame.origin.y = cell.textDescription.frame.origin.y + 30
        l.sizeToFit()
        collectionView.addSubview(l)
        
        let img = String(format: "%@%@", Constants.urlImages, (detailMovie[indexPath.item].backdrop_path)!)
        
        cell.imageBanner.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageBanner!.sd_setImage(
            with: URL(string: img),
            placeholderImage: nil,
            options: SDWebImageOptions(rawValue: 0),
            completed: { image, error, cacheType, imageURL in
                
                //cell.imageBanner.clipsToBounds = true
                
                if (error != nil) {
                    // Failed to load image
                } else {
                    // Successful in loading image
                    cell.imageBanner.image = image
                }
            }
        )
        
        return cell
    }
    
    func changeDate(string: String) -> String {
        let fullDate = string.components(separatedBy: "-")

        let year    = fullDate[0]
        let month = fullDate[1]
        var day = fullDate[2]
        
        if (day == "01"){
            day = "1"
        } else if (day == "02"){
            day = "2"
        } else if (day == "03"){
            day = "3"
        } else if (day == "04"){
            day = "4"
        } else if (day == "05"){
            day = "5"
        } else if (day == "06"){
            day = "6"
        } else if (day == "07"){
            day = "7"
        } else if (day == "08"){
            day = "8"
        } else if (day == "09"){
            day = "9"
        }
        
        var newMonth = ""
        if (month == "01"){
            newMonth = "january"
        } else if (month == "02"){
            newMonth = "february"
        } else if (month == "03"){
            newMonth = "march"
        } else if (month == "04"){
            newMonth = "april"
        } else if (month == "05"){
            newMonth = "may"
        } else if (month == "06"){
            newMonth = "june"
        } else if (month == "07"){
            newMonth = "july"
        } else if (month == "08"){
            newMonth = "august"
        } else if (month == "09"){
            newMonth = "september"
        } else if (month == "10"){
            newMonth = "october"
        } else if (month == "11"){
            newMonth = "november"
        } else if (month == "12"){
            newMonth = "december"
        }
        
        let newDate = day + " " + newMonth + " " + year
        
        return newDate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class CellDetail: UICollectionViewCell {
    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var textTime: UILabel!
    @IBOutlet weak var textRelease: UILabel!
    @IBOutlet weak var textScore: UILabel!
    @IBOutlet weak var textGenders: UILabel!
    @IBOutlet weak var textDescription: UILabel!
    
}

