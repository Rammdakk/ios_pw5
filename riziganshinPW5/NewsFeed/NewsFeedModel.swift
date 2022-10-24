//
// Created by Рамиль Зиганшин on 24.10.2022.
//

enum NewsFeedModel {
    enum GetNews {
        struct Request {
        }

        struct Response {
            var articles: NewsList
        }
    }

    // MARK: - News

    struct NewsList: Decodable {
        let articles: [Article]?
    }

    // MARK: - Article

    struct Article: Decodable {
        let source: Source?
        let author: String?
        let title: String?
        let description: String?
        let sourceLink: String?
        let imageLink: String?
        let publishTime: String?
        let content:String?

        enum CodingKeys: String, CodingKey {
            case source, author, title, description, content
            case sourceLink = "url"
            case imageLink = "urlToImage"
            case publishTime = "publishedAt"
        }
    }

    // MARK: -Source

    struct Source: Decodable {
        let id: String?
        let name: String?
    }

}

