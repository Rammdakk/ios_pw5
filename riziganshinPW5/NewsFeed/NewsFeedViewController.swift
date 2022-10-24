//
//  NewsFeedViewController.swift
//  riziganshinPW5
//
//  Created by Рамиль Зиганшин on 20.10.2022.
//

import UIKit

protocol NewsFeedDispayLogic: AnyObject {
    typealias Model = NewsFeedModel
    func displayData(_ viewModel: Model.GetNews.ViewModel)
}

class NewsFeedViewController: UIViewController {

    // MARK: - External vars

    // MARK: - Internal vars
    private var interactor: NewsFeedBuisnessLogic
    private var tableView = UITableView(frame: .zero, style: .plain)
    private var isLoading = false
    private var newsViewModels: Model.NewsList = Model.NewsList(articles: [])

    // MARK: - Lifecycle

    init(interactor: NewsFeedBuisnessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor.fetchNews(Model.GetNews.Request())
    }


    // MARK: -UI

    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureTableView()
    }

    private func configureTableView() {
        setTableViewUI()
        setTableViewDelegate()
        setTableViewCell()
    }

    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setTableViewUI() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 120
        tableView.pinLeft(to: view)
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinRight(to: view)
        tableView.pinBottom(to: view)
    }

    private func setTableViewCell() {
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }

    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 0
        } else {
            return newsViewModels.articles?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
        } else {
            let viewModel = newsViewModels.articles?[indexPath.row]
            if let newsCell = tableView.dequeueReusableCell(withIdentifier:
            NewsCell.reuseIdentifier, for: indexPath) as? NewsCell {
                newsCell.configure(with: viewModel)
                return newsCell
            }
        }
        return UITableViewCell()
    }
}

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isLoading {
            let newsVC = NewsViewController()
            navigationController?.pushViewController(newsVC, animated: true)
        }
    }
}

// MARK: - Display Logic
extension NewsFeedViewController: NewsFeedDispayLogic {
    func displayData(_ viewModel: Model.GetNews.ViewModel) {
        newsViewModels = viewModel.news
        reloadData()
    }

    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}