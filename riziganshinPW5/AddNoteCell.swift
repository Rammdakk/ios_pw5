//
// Created by Рамиль Зиганшин on 06.10.2022.
//

import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell, UITextViewDelegate {
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()

    var delegate: AddNoteDelegate?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(to: 100)
        textView.text = "Type smth"
        textView.delegate = self
        textView.isScrollEnabled = true
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.alpha = 0.5
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)),
                for: .touchUpInside)
        addButton.isEnabled = false
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .tertiaryLabel {
            textView.text = nil
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if (textView.text.count > 0) {
            addButton.alpha = 1
            addButton.isEnabled = true
        } else {
            addButton.alpha = 0.5
            addButton.isEnabled = false
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type smth"
            textView.textColor = .tertiaryLabel
            addButton.alpha = 0.5
            addButton.isEnabled = false
        }
    }


    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if (textView.text.count > 0) {
            delegate?.newNoteAdded(note: ShortNote(text: textView.text))
            clearTextView()
        }
    }

    private func clearTextView() {
        textView.text = "Type smth"
        textView.textColor = .tertiaryLabel
        addButton.isEnabled = false
        addButton.alpha = 0.5
    }
}

