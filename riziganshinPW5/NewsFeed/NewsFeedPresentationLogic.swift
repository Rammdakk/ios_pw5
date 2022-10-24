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
extension NewsFeedPresenter: NewsFeedPresentationLogic{
    func presentData(_ response: Model.GetNews.Response) {
        viewController?.displayData(Model.GetNews.ViewModel(news: response.articles))
    }
}
