//
//  ListView.swift
//  MovieDB
//
//  Created by Cristian Hernandez Garcia on 26/09/20.
//  Copyright © 2020 Cristian Hernandez Garcia. All rights reserved.
//

import UIKit
import SDWebImage
import KRProgressHUD

class ListView: UIViewController, ListViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var presenter:ListPresenterProtocol?
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    var moviesArray: Array<Results> = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configVIPER()
        configUI()
    }
    
    func configVIPER(){
        ListRouter.createModule(listRef: self)
        presenter?.viewDidLoad()
        
        getMovieData()
    }
        
    func configUI(){
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionMovies.alwaysBounceVertical = true
        collectionMovies.refreshControl = refreshControl
        
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        getMovieData()
        refreshControl.endRefreshing()
    }
        
    func getMovieData(){
        refreshControl.endRefreshing()
        
        if Reachability.isConnectedToNetwork(){
            self.presenter?.getData()
        } else {
            KRProgressHUD.dismiss()
            
            let alertController = UIAlertController(title: "Verifica tu conexión a internet", message: "", preferredStyle: .alert)

            let tryAgain = UIAlertAction(title: "Intentar de nuevo", style: .default, handler: { alert -> Void in
                self.presenter?.getData()
            })

            let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: { alert -> Void in
                self.dismiss(animated: true, completion: nil)
            })

            alertController.addAction(tryAgain)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func receiveMovies(movies: [Results]) {
        
        moviesArray = movies
        collectionMovies.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(moviesArray[indexPath.row])
        presenter?.goToDetail(movie: moviesArray[indexPath.row])
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionMovies.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size*1.5)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMovie", for: indexPath) as! CellMovie
        
        cell.layer.cornerRadius = 12
        cell.textName.text = (moviesArray[indexPath.item].title)!
        cell.textDate.text = (moviesArray[indexPath.item].release_date)!
        
        let votes: String = String(format: "%.1f", (moviesArray[indexPath.item].vote_average)!)
        cell.textPoints.text = votes
        
        let img = String(format: "%@%@", Constants.urlImages, (moviesArray[indexPath.item].poster_path)!)
        
        cell.imagePoster.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imagePoster!.sd_setImage(
            with: URL(string: img),
            placeholderImage: nil,
            options: SDWebImageOptions(rawValue: 0),
            completed: { image, error, cacheType, imageURL in
                
                cell.imagePoster.layer.cornerRadius = 12
                cell.imagePoster.clipsToBounds = true
                
                if (error != nil) {
                    // Failed to load image
                } else {
                    // Successful in loading image
                    cell.imagePoster.image = image
                }
            }
        )
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class CellMovie: UICollectionViewCell {
    @IBOutlet weak var textName: UILabel!
    @IBOutlet weak var textDate: UILabel!
    @IBOutlet weak var textPoints: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var imageStar: UIImageView!
}

