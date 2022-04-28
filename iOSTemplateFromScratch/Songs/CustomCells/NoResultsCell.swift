//
//  NoResultsCell.swift
//  iOSTemplateFromScratch
//
//  Created by Apple on 19/04/22.
//

import Foundation
import UIKit

class NoResultsCell: UITableViewCell {
    let noResultLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        addSubview(noResultLabel)
        NSLayoutConstraint.activate([
            noResultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            noResultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            noResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            noResultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}
