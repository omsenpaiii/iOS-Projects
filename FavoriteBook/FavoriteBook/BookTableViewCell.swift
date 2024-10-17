//
//  BookTableViewCell.swift
//  FavoriteBooks
//
//  Created by student-2 on 10/17/24.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func update(with book: Book) {
        genreLabel.text = book.genre
        titleLabel.text = book.title
        authorLabel.text = book.author
    }
    
}

