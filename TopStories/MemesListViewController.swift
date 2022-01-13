//
//  MemesListViewController.swift
//  TopStories
//
//  Created by Aiden Seibel on 1/5/22.
//

import UIKit

var selectedMeme: [String: String] = [:]
var memes = [[String: String]]()


class MemesListViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Memes"
        let query = "https://api.imgflip.com/get_memes"
        
        let url = URL(string: query)!
        
        
        DispatchQueue.global().async{
            if let data = try? Data(contentsOf: url){
                if let json = try? JSON(data:data), json["success"] == true{
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
        let newJSON = json["data"]
        for result in newJSON["memes"].arrayValue{
            
            let memeId = result["id"].stringValue
            let memeName = result["name"].stringValue
            let memeURL = result["url"].stringValue
            let meme = ["id": memeId, "name": memeName, "url" : memeURL]
            
            print(meme)
            
            memes.append(meme)
            
        }
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func showError(){
        DispatchQueue.main.async{
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the memes", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTitleCell", for: indexPath)
        let source = memes[indexPath.row]
        cell.textLabel?.text = source["name"]
        cell.detailTextLabel?.text = source["url"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let memeViewerVC = segue.destination as? MemeViewViewController {
             let index = tableView.indexPathForSelectedRow?.row
             selectedMeme = memes[index!]
        }
    }
}


