//
//  ViewController.swift
//  TopStories
//
//  Created by Aiden Seibel on 1/5/22.
//

import UIKit

class SourcesViewController: UITableViewController {

    var sources = [[String: String]]()
    let apiKey = "d45229539c5d4c6ea40599abe7ec48c8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "News Sources"
        let query = "https://newsapi.org/v1/sources?language=en&country=us&apiKey=\(apiKey)"
        
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
        for result in json["sources"].arrayValue {
            print(result)
            
            let id = result["id"].stringValue
            let name = result["name"].stringValue
            let description = result["description"].stringValue
            
            let source = [ "id": id, "name": name, "description" : description]
            
            sources.append(source)
            
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
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsSourceCell", for: indexPath)
        let source = sources[indexPath.row]
        cell.textLabel?.text = source["name"]
        cell.detailTextLabel?.text = source["description"]
        return cell
    }
}


