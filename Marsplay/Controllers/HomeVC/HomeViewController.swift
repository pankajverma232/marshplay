//
//  ViewController.swift
//  Marsplay
//
//  Created by Pankaj Verma on 05/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    let  cellIdentifier = "MovieCell";
 
    var page:Int = 1{
        willSet(nextPage) {
            omdbUrlString = "http://www.omdbapi.com/?s=Batman&page=\(nextPage)&apikey=eeefc96f"
        }

    }
    var omdbUrlString = "http://www.omdbapi.com/?s=Batman&page=1&apikey=eeefc96f"
    var totalMovies = 0;
    var movieData: [MovieModel] = []{
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        cell.configure(with: movieData[indexPath.row])
        return cell;
    }
    
    //MARK:- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieData.count - 1 && movieData.count < totalMovies {
            //last cell, load more...
                page += 1;
                loadMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.movieDetail = movieData[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = CustomFlowLayout()
        loadMovies()
    }
    
    func loadMovies() -> Void {
        guard let omdbUrl = URL(string: omdbUrlString) else { return }
        
        URLSession.shared.dataTask(with: omdbUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                
                let dt = try decoder.decode(Root.self, from: data)
                DispatchQueue.main.async { [unowned self] in
                    if let movies = dt.search{
                        self.movieData.append(contentsOf: movies)
                    }
                    
                    if let countString = dt.count {
                        if let count = Int(countString){
                        self.totalMovies = count
                        }
                    }
                }
                
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}

