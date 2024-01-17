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
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    
}

extension BookCollectionViewCell {
    
    func setUI() {
        backView.backgroundColor = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 0.7)
        backView.layer.cornerRadius = 10
    }
    
    func configureCell(item: Document) {
        
        nameLabel.text = item.title
        
        rateLabel.text = item.isbn
        
        let url = URL(string: item.thumbnail)
        bookImageView.kf.setImage(with: url)
    }
}
