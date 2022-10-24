//
// Created by Рамиль Зиганшин on 24.10.2022.
//

import UIKit


protocol NewsFeedWorkerLogic {
    typealias Model = NewsFeedModel
    func getNews(_ request: Model.GetNews.Request, completion: @escaping (Model.NewsList) -> ())
    func loadImage(from urlString: String, completion: @escaping (_ data: Data?) -> ())
}

class NewsFeedWorker: NewsFeedWorkerLogic {
    private let decoder: JSONDecoder = JSONDecoder()
    private let session: URLSession = URLSession.shared

    func getNews(_ request: Model.GetNews.Request, completion: @escaping (Model.NewsList) -> ()) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a0f0ca4c07e842bf958fda9c7271408c") else {
            return
        }
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if
                    let data = data,
                    let news = try? self?.decoder.decode(Model.NewsList.self, from: data) {
                completion(news)
            } else {
                print("Could not get any content")
            }
        }

        task.resume()
    }

    func loadImage(from urlString: String, completion: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
            return
        }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            } else {
                print("Could not load image")
            }
        }

        dataTask.resume()
    }

}
