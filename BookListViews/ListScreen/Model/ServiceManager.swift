//
//  ServiceManager.swift
//  BookListViews
//
//  Created by Colin Murphy on 9/22/20.
//

// import Alamofire
import UIKit

class ServiceManager {

    // MARK: - Variables

    static let manager = ServiceManager()
    private let cache = NSCache<NSString, UIImage>()

    // MARK: - Init

    private init() { }

    // MARK: - Methods

    func request(withUrl url: URL, completed: @escaping (Any?, Error?) -> Void) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse, (response.statusCode == 200) else {
                DispatchQueue.main.async {
                    completed(nil, error)
                }
                return
            }

            DispatchQueue.main.async {
                completed(data, nil)
                return
            }
        }.resume()
    }

    /*
    func alamoRequest() {
        
        AF.request("https://www.googleapis.com/books/v1/volumes?q=coding")
            .validate()
            .responseDecodable(of: ApiResponse.self) { (response) in
                guard let data = response.value else { return }
                print("alamoRequest: ", data)
        }
    }
     */

    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {

        let cacheKey = NSString(string: urlString)

        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }

        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                    completed(image)
                    return
                } catch {
                    print(error)
                    completed(nil)
                    return
                }
            }
        }
    }
}
