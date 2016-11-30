//
//  TableViewController.swift
//  quiz_test
//
//  Created by Konada on 11/28/16.
//  Copyright © 2016 Konada. All rights reserved.
//

import UIKit

	var quizLink: String!

class TableViewController: UITableViewController {
	
	var refreshCtrl: UIRefreshControl!
	var tableData:[Any]!
	var task: URLSessionDownloadTask!
	var session: URLSession!
	var cache:NSCache<AnyObject, AnyObject>!
	var quizID: Int64 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
			
			session = URLSession.shared
			task = URLSessionDownloadTask()
			
			self.refreshCtrl = UIRefreshControl()
			self.refreshCtrl.addTarget(self, action: #selector(TableViewController.refreshTableView), for: .valueChanged)
			self.refreshControl = self.refreshCtrl
			
			self.tableData = []
			self.cache = NSCache()
			refreshTableView()
	
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.tableData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
		let dictionary = self.tableData[(indexPath as NSIndexPath).row] as! [String:AnyObject]
		cell.quizImage?.image = UIImage(named: "placeholder")
		cell.quizTitleLabel.text = dictionary["title"] as? String
		//quizID = dictionary["id"] as! Int64
		//print("\(quizID)")
		
		if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
			// Use cache
			print("Cached image used, no need to download it")
			cell.quizImage?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
		}else{
			let artworkUrl = (dictionary["mainPhoto"] as?NSDictionary)?["url"] as! String
			let url:URL! = URL(string: artworkUrl)
			task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
    if let data = try? Data(contentsOf: url){
			DispatchQueue.main.async(execute: { () -> Void in
    // Before we assign the image, check whether the current cell is visible
    if let updateCell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
			let img:UIImage! = UIImage(data: data)
			updateCell.quizImage?.image = img
			self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
				}
			})
				}
			})
			task.resume()
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
		let dictionary = self.tableData[(indexPath as NSIndexPath).row] as! [String:AnyObject]
		quizID = dictionary["id"] as! Int64
		quizLink = "\(quizID)"
	}

	
	func refreshTableView(){
		
		let url:URL! = URL(string: "http://quiz.o2.pl/api/v1/quizzes/0/5")
		task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
			
			if location != nil{
				let data:Data! = try? Data(contentsOf: location!)
				do{
					let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
					self.tableData = dic.value(forKey : "items") as? [AnyObject]
					DispatchQueue.main.async(execute: { () -> Void in
						self.tableView.reloadData()
						self.refreshControl?.endRefreshing()
						//print(self.tableData)
					})
				}catch{
					print("something went wrong, try again")
				}
			}
		})
  task.resume()
	}


	}




