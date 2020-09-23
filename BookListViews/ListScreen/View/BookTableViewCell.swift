//
//  BookTableViewCell.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    static let reuseID  = "BookTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(using itemInfo: VolumeInfo) {
        
        self.titleLabel.text = itemInfo.title
        self.subTitleLabel.text = itemInfo.subTitle
        self.subTitleLabel.isHidden = itemInfo.subTitle?.isEmpty ?? true
        
        self.bookImageView.backgroundColor = .white
        self.bookImageView.layer.cornerRadius = 15
        self.bookImageView.layer.borderWidth = 1.5
        self.bookImageView.layer.borderColor = UIColor.systemGray.cgColor
        
        if let urlString = itemInfo.imageLinks?.smallThumbnail {
            ServiceManager.manager.downloadImage(from: urlString, completed: { (image) in
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            })
        }
    }
}
