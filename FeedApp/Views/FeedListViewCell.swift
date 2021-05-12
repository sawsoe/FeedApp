//
//  FeedListViewCell.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import LBTATools

class FeedListViewCell: UICollectionViewCell {
    
    var imageView = UIImageView(backgroundColor: .blue)
    var titleLabel = UILabel(text: "Sample text", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left, numberOfLines: 2)
    var bodyLabel = UILabel(text: "Boday text...", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
