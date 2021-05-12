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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed List"
        //enable large title in nav bar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(FeedListViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        
        collectionView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
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

extension FeedListCollectionViewController{
    @objc func loadDataFromFile(){
        if let path = Bundle.main.path(forResource: "response", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = JSON(data)
                
                //clean feedList
                feedList.removeAll()
                
                for jsonObject in jsonResult.arrayValue {
                    
                    let feed:Feed = Feed()
                    feed.fromJSON(jsonData: jsonObject)
                    feedList.append(feed)
                }
                
                //reload the view to show update data
                print("Loaded data from json file")
                refreshControl.endRefreshing()
                collectionView.reloadData()
                
            } catch {
                print("Failed to load data from json file")
            }
        }
    }
    
    @objc func loadDataFromApi(){
        
        let url = "https://ios-code-challenge.mockservice.io/posts"
        self.refreshControl.beginRefreshing()
        
        var request = URLRequest(url: URL(string: url)! as URL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 4 //4 sec
        
        AF.request(request as URLRequestConvertible).responseJSON {
            response in
            
            switch response.result {
            case .success(let value):
                let jsonResult = JSON(value)
                
                //clean feedList
                self.feedList.removeAll()
                
                for jsonObject in jsonResult.arrayValue {
                    
                    let feed:Feed = Feed()
                    feed.fromJSON(jsonData: jsonObject)
                    self.feedList.append(feed)
                }
                print("Loaded data from api")
                
            case .failure(let error):
                print("Failed to fetch data from api")
                self.loadDataFromFile()
                break
            }
            
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
        
    }
}
