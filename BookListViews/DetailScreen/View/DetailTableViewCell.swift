//
//  DetailTableViewCell.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var detailTypeLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!

    static let reuseID  = "DetailTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(type: String, info: Any) {

        self.detailTypeLabel.text = type

        if let data = info as? Int {
            self.infoLabel.text = "\(data)"
        } else if let data = info as? [String] {
            self.infoLabel.text = data.joined(separator: ", ")
        } else if let data = info as? String {
            self.infoLabel.text = data
        }
    }
}
