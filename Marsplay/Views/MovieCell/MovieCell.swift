//
//  MovieCell.swift
//  Marsplay
//
//  Created by Pankaj Verma on 05/10/18.
//  Copyright © 2018 Pankaj Verma. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    lazy var imgSaver:ImageSaver = ImageSaver()

    public func configure(with model: MovieModel) {
        
        if let imgData = imgSaver.getImageForKey(model.posterImageUrl){
            let image = UIImage(data: imgData)
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }else{
            posterImageView.image = UIImage(named: "poster")
            loadImage(forUrl: model.posterImageUrl)
        }
        
        titleLabel.text = model.title
        typeLabel.text = model.type
        if let strYear = model.year{
            if let number = Int(strYear) {
                yearLabel.text = "\(2018 - number) years ago."
            }
        }
    }
    

    
    func loadImage(forUrl posterImageUrl:String?) -> Void {
        if posterImageUrl == nil {return}
        DispatchQueue(label: "marsplay").async {
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
