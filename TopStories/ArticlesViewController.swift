//
//  ViewController.swift
//  TopStories
//
//  Created by Aiden Seibel on 1/5/22.
//

import UIKit

class ArticlesViewController: UITableViewController {

    var articles = [[String: String]]()
    var source = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top Stories"
        let query = "https://newsapi.org/v1/articles?source= \(source["id"]!)&apiKey= \(apiKey)"
            
        let url = URL(string: query)!
        
        
        DispatchQueue.global().async{
            if let data = try? Data(contentsOf: url){
                if let json = try? JSON(data:data), json["status"] == "ok"{
                    self.parse(json: json)
                }else{
                    self.showError()
                }
            } else{
                self.showError()
            }
        }
        
        
        
        
    }
    
    func parse(json: JSON){
        for result in json["articles"].arrayValue {
             let title = result[ "title"].stringValue
             let description = result[ "description" ].stringValue
             let url = result[ "url"].stringValue
             let article = [ "title": title, "description" : description,
             "url": url]
             articles.append(article)
        }
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func showError(){
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the news feed", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]
        cell.detailTextLabel?.text = article["description"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedArticle = articles[indexPath.row]
        let url = URL(string: tappedArticle["url"]!)
        UIApplication.shared.open(url!)
    }
}


