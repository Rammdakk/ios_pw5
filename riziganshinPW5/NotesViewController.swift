//
//  NotesViewController.swift
//  riziganshinPW4
//
//  Created by Рамиль Зиганшин on 06.10.2022.
//

import UIKit

final class NotesViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ShortNote(text: "a"), ShortNote(text: "b"), ShortNote(text: "c")]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }

    private func setupView() {
        setupNavBar()
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier:
        NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier:
        AddNoteCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.pinTopVal(to: self.view, 35)
    }

    private func setupNavBar() {
        let closeButton = UIButton(type: .close)
        closeButton.addTarget(self, action: #selector(dismissViewController(_sender:)),
                for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView:
        closeButton)
        let title = UILabel()
        title.text = "Notes"
        title.textAlignment = .center
        title.backgroundColor = .clear
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        let stackView = UIStackView(arrangedSubviews: [title, closeButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.pin(to: view, [.left: 60, .top: 15, .right: 20])
    }

    @objc
    func dismissViewController(_sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

extension NotesViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
            UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
            AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
            NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(data: note)
                return noteCell
            }
        }
        return UITableViewCell()
    }

    private func handDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
    indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0:
            return nil
        default:
            let deleteAction = UIContextualAction(
                    style: .destructive,
                    title: .none
            ) { [weak self] (action, view, completion) in
                self?.handleDelete(indexPath: indexPath)
                completion(true)
            }
            deleteAction.image = UIImage(
                    systemName: "trash.fill",
                    withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
            )?.withTintColor(.white)
            deleteAction.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
    }
}
     
