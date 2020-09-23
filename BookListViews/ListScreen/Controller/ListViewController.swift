//
//  ViewController.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var booksTableView: UITableView! {
        didSet {
            self.booksTableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Variables
    
    var datasource: [ItemInfo] = [] {
        didSet {
            self.booksTableView.reloadData()
        }
    }
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDataFromServer()
    }
    
    // MARK: - Methods
    
    func getDataFromServer() {
        
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=coding") else { return }
        self.activityIndicator.startAnimating()
        
        ServiceManager.manager.request(withUrl: url) { (data, error) in
            guard let dataObj = data as? Data else { return}
            
            do {
                let responseObj = try JSONDecoder().decode(ApiResponse.self, from: dataObj)
                self.datasource = responseObj.items ?? []
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            } catch {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            detailVC.info = self.datasource[indexPath.row].volumeInfo
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.reuseID) as? BookTableViewCell else { fatalError("could not create BookTableViewCell") }
        
        cell.bookImageView.image = nil
        
        if let volumeInfo = self.datasource[indexPath.row].volumeInfo {
            cell.configure(using: volumeInfo)
        }
        
        return cell
    }
}
