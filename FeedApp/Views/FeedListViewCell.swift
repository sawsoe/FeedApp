//
//  FeedListViewCell.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import LBTATools

///Custom Feed Cell for CollectionView
class FeedListViewCell: UICollectionViewCell {
    
    var feedData: Feed?{
        didSet{
            if let data = feedData{
                imageView.loadImage(urlString: data.imageUrl!)
                titleLabel.text = data.title
                bodyLabel.text = data.body
            }
        }
    }
    
    let imageView : CachedImageView = {
        let img = CachedImageView()
        img.image = UIImage()
        img.backgroundColor = .lightGray
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    let titleLabel = UILabel(text: "Sample text", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .left, numberOfLines: 2)
    let bodyLabel = UILabel(text: "Body text...\naa\naa", font: .systemFont(ofSize: 12), textColor: .black, textAlignment: .left, numberOfLines: 4)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        
        stack(imageView.withHeight(170),
              stack(titleLabel, bodyLabel).withMargins(.allSides(14)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
