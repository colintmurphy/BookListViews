//
//  BookTableViewCell.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet private weak var bookImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

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

        self.bookImageView.image = nil
        self.bookImageView.backgroundColor = .white
        self.bookImageView.layer.cornerRadius = 15
        self.bookImageView.layer.borderWidth = 1.0
        self.bookImageView.layer.borderColor = UIColor.systemGray.cgColor

        if let urlString = itemInfo.imageLinks?.smallThumbnail {
            ServiceManager.manager.downloadImage(from: urlString) { image in
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            }
        }
    }
}
