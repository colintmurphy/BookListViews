//
//  BookCollectionViewCell.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    static let reuseID  = "BookCollectionViewCell"
    
    func configure(using itemInfo: VolumeInfo) {
        
        self.bookImageView.image = nil
        self.bookImageView.layer.cornerRadius = 10
        self.bookImageView.layer.borderWidth = 1.0
        self.bookImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.titleLabel.text = itemInfo.title
        if let urlString = itemInfo.imageLinks?.smallThumbnail {
            
            ServiceManager.manager.downloadImage(from: urlString, completed: { (image) in
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            })
        }
    }
}
