//
// Created by Рамиль Зиганшин on 06.10.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    static let reuseIdentifier = "NoteCell"
    private var textView = UITextView()


    func configure(data: ShortNote) {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        textView.text = data.text
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 8
        let stackView = UIStackView(arrangedSubviews: [textView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 5, .top: 5, .right: 5, .bottom: 5])
        contentView.backgroundColor = .systemGray5

    }


    override func prepareForReuse() {
        super.prepareForReuse()
        textView.text = ""
    }
}
