//
//  DetailViewController.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import SafariServices
import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    
    // MARK: - Variables
    
    var info: VolumeInfo?
    var labelInfo: [(title: String, data: Any)] = []
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        
        let webButton = UIBarButtonItem(title: "View Online", style: .plain, target: self, action: #selector(self.viewOnline))
        self.navigationItem.rightBarButtonItem = webButton
        
        if let imageUrl = info?.imageLinks?.thumbNail {
            ServiceManager.manager.downloadImage(from: imageUrl) { (image) in
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            }
        }
        
        if let info = self.info?.getNonNilItems() {
            self.labelInfo = info
            self.detailTableView.reloadData()
        }
    }
    
    // MARK: - View Online
    
    @objc func viewOnline() {
        
        if let urlString = self.info?.previewLink,
           let url = URL(string: urlString){
            self.presentSafariVC(with: url)
        }
    }
    
    func presentSafariVC(with url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.labelInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseID) as? DetailTableViewCell else { fatalError("couldn't create DetailTableViewCell") }
        
        cell.detailTypeLabel.text = self.labelInfo[indexPath.row].title
        
        if let data = self.labelInfo[indexPath.row].data as? Int {
            cell.infoLabel.text = "\(data)"
        } else if let data = self.labelInfo[indexPath.row].data as? [String] {
            cell.infoLabel.text = data.joined(separator: ", ")
        } else if let data = self.labelInfo[indexPath.row].data as? String {
            cell.infoLabel.text = data
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DetailViewController: UITableViewDelegate { }

// MARK: - SFSafariViewControllerDelegate

extension DetailViewController: SFSafariViewControllerDelegate { }
