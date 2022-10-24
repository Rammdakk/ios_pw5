//
//  NewsFeedPresentationLogic.swift
//  riziganshinPW5
//
//  Created by Рамиль Зиганшин on 20.10.2022.
//

import UIKit

protocol NewsFeedPresentationLogic {
    typealias Model = NewsFeedModel
    func presentData(_ response: Model.GetNews.Response)
}

class NewsFeedPresenter {
    // MARK: - External vars
    weak var viewController: NewsFeedDispayLogic?
}

// MARK: - PresentationLogic

extension NewsFeedPresenter: NewsFeedPresentationLogic {
    func presentData(_ response: Model.GetNews.Response) {

        let data: [NewsViewModel]? = response.articles.articles?.map { (element: NewsFeedModel.Article) in
            NewsViewModel(title: element.title ?? "", description: element.description ?? "",
                    imageURL: element.imageLink ?? "https://img.favpng.com/1/0/19/apartment-renting-london-residential-house-product-png-favpng-HDu76aTH05LPrzJjry2ktzTpc.jpg")
        }

        viewController?.displayData(data ?? [NewsViewModel]())
    }
}
