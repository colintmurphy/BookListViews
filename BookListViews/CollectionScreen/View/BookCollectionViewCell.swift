//
//  BookCollectionViewCell.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let reuseID  = "BookCollectionViewCell"
    
    func configure(using itemInfo: VolumeInfo) {
        
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
