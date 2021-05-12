//
//  FeedListViewCell.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import LBTATools

class FeedListViewCell: UICollectionViewCell {
    
    var imageView = UIImageView(backgroundColor: .blue)
    var titleLabel = UILabel(text: "Sample text", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 2)
    var bodyLabel = UILabel(text: "Body text...\naa\naa", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        self.backgroundColor = .lightGray
        self.layer.borderWidth = 1
        
        stack(imageView.withHeight(150),
              stack(titleLabel, bodyLabel).withMargins(.allSides(14)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
