//
//  CollectionViewController.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet private weak var booksCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Variables

    private var datasource: [ItemInfo] = [] {
        didSet {
            self.booksCollectionView.reloadData()
        }
    }

    // MARK: - View Life Cycles

    override func viewDidLoad() {

        super.viewDidLoad()
        self.getDataFromServer()
    }

    // MARK: - Methods
    
    /*
     sync: blocking it
     async: not blocking it, it will do whatever in the { }'s and it leave and continue running whatever comes after async while still in the { }'s
     */

    private func getDataFromServer() {

        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=coding") else { return }
        self.activityIndicator.startAnimating()

        ServiceManager.manager.request(withUrl: url) { data, error in
            guard let dataObj = data as? Data else { return }
            do {
                let responseObj = try JSONDecoder().decode(ApiResponse.self, from: dataObj)
                self.datasource = responseObj.items ?? []
                self.stopActivity()
            } catch {
                self.stopActivity()
                print(error)
            }
        }
    }

    private func stopActivity() {

        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseID,
                                                            for: indexPath) as? BookCollectionViewCell else { fatalError("could make BookCollectionViewCell") }

        if let volumeInfo = self.datasource[indexPath.row].volumeInfo {
            cell.configure(using: volumeInfo)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        collectionView.deselectItem(at: indexPath, animated: true)
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailVC.info = self.datasource[indexPath.row].volumeInfo
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
