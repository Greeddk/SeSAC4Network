//
//  BookTableViewCell.swift
//  SeSAC4Network
//
//  Created by Greed on 1/17/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialUI()
    }

}

extension BookCollectionViewCell {
    
    func initialUI() {
        
        backView.backgroundColor = .white
        
        nameLabel.textColor = .white
        nameLabel.text = ""
        
        authorLabel.textColor = .white
        authorLabel.text = ""
    }
    
    func setUI() {
        backView.backgroundColor = UIColor(red: .random(in: 0.3...1), green: .random(in: 0.3...1), blue: .random(in: 0.3...1), alpha: 0.7)
        backView.layer.cornerRadius = 10
        
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.font = .boldSystemFont(ofSize: 18)
        
        authorLabel.textColor = .white
        authorLabel.numberOfLines = 2
        authorLabel.font = .systemFont(ofSize: 12)
    }
    
    func configureCell(item: Document) {
        
        nameLabel.text = item.title
        
        if item.authors.count == 0 {
            authorLabel.text = ""
        } else {
            authorLabel.text = item.authors[0]
        }
        
        let url = URL(string: item.thumbnail)
        bookImageView.kf.setImage(with: url)
        
        setUI()
    }
}
