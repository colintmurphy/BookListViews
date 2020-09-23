//
//  DetailTableViewCell.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    static let reuseID  = "DetailTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
