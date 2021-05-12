//
//  FeedListCollectionViewController.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import LBTATools
import SwiftyJSON

class FeedListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "feedListCellID"
    var feedList = [Feed]()
    
    func loadDataFromFile(){
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = JSON(data)
                
                for jsonObject in jsonResult.arrayValue {
                    
                    let feed:Feed = Feed()
                    feed.fromJSON(jsonData: jsonObject)
                    feedList.append(feed)
                }
                
                //reload the view to show update data
                collectionView.reloadData()
                
            } catch {
                // handle error
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(FeedListViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        
        loadDataFromFile()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? FeedListViewCell
        cell?.feedData = feedList[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 270)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cliked on : " + feedList[indexPath.row].title!)
    }
    
}
