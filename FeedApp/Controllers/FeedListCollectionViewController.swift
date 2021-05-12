//
//  FeedListCollectionViewController.swift
//  FeedApp
//
//  Created by SawSMN's MacBook Pro on 12/5/21.
//

import LBTATools
import SwiftyJSON
import Alamofire

class FeedListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "feedListCellID"
    var feedList = [Feed]()
    var refreshControl : UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(loadDataFromApi), for: .valueChanged)
        return control
    }()
    
    @objc func loadDataFromFile(){
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = JSON(data)
                
                print("Load data from json file")
                //clean feedList
                feedList.removeAll()
                
                for jsonObject in jsonResult.arrayValue {
                    
                    let feed:Feed = Feed()
                    feed.fromJSON(jsonData: jsonObject)
                    feedList.append(feed)
                }
                
                //reload the view to show update data
                refreshControl.endRefreshing()
                collectionView.reloadData()
                
            } catch {
                print("Failed to load data from json file")
            }
        }
    }
    
    @objc func loadDataFromApi(){
        
        let url = "https://ios-code-challenge.mockservice.io/posts"
        AF.request(url, method: .get, parameters: nil).responseJSON { [self] (response) in
            self.feedList.removeAll()
            
            switch response.result {
            case .success(let value):
                let jsonResult = JSON(value)
                
                //clean feedList
                feedList.removeAll()
                
                for jsonObject in jsonResult.arrayValue {
                    
                    let feed:Feed = Feed()
                    feed.fromJSON(jsonData: jsonObject)
                    feedList.append(feed)
                }
            case .failure(let error):
                print("Failed to fetch data from api: \n" + error.localizedDescription)
                loadDataFromFile()
                break
            // error handling
            }
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed List"
        //enable large title in nav bar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(FeedListViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        
        collectionView.addSubview(refreshControl)
        
        loadDataFromApi()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top spacing between collectionview and largeTitle
        return .init(top: 15, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cliked on : " + feedList[indexPath.row].title!)
    }
    
}
