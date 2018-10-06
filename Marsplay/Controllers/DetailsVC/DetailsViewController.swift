//
//  DetailsViewController.swift
//  Marsplay
//
//  Created by Pankaj Verma on 05/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var imdbIdLabel: UILabel!
    @IBOutlet weak var posterUrl:UILabel!
    
    lazy var imgSaver:ImageSaver = ImageSaver()
    var movieDetail:MovieModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imgData = imgSaver.getImageForKey(movieDetail?.posterImageUrl){
            let image = UIImage(data: imgData)
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }else{
            posterImageView.image = UIImage(named: "poster")
            loadImage(forUrl: movieDetail?.posterImageUrl)
        }
        titleLabel.text = movieDetail?.title
        typeLabel.text = movieDetail?.type
        yearLabel.text = movieDetail?.year
        imdbIdLabel.text = movieDetail?.id
        posterUrl.text = movieDetail?.posterImageUrl
    }
    func loadImage(forUrl posterImageUrl:String?) -> Void {
        DispatchQueue(label: "marsplay1").async {
            if let urlString = posterImageUrl{
                if let imgUrl = URL.init(string: urlString){
                    let imageData = try? Data.init(contentsOf:imgUrl)
                    if let data = imageData{
                        let image = UIImage(data: data)
                        //resize if needed
                        
                        DispatchQueue.main.async {
                            self.imgSaver.addImage(data: data, forKey: posterImageUrl!)
                            self.posterImageView.image = image
                        }
                    }
                }
            }
        }
    }

}
