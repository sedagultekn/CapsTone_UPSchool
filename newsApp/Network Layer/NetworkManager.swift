//
//  Network.swift
//  newsApp
//
//  Created by Seda Gültekin on 16.09.2023.
//

import Foundation
class NetworkManager {

    static let shared = NetworkManager()

    func fetchNews(url: URL, completion: @escaping (_ articles: [Article]) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data else {
                print("error")
                return
            }

            do {
                let news = try JSONDecoder().decode(NewsModel.self, from: data)
                completion(news.articles ?? [])
                print(news)
                print(response)

            } catch {
                print(error.localizedDescription)
            }
        }

        task.resume()
    }
}
