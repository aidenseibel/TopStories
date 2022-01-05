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
        
    }
}


