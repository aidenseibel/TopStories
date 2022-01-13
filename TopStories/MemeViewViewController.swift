//
//  ViewController.swift
//  TopStories
//
//  Created by Aiden Seibel on 1/5/22.
//

import UIKit
import SafariServices

class MemeViewViewController: UIViewController {

    @IBOutlet weak var memeNameLabel: UILabel!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        memeNameLabel.text = selectedMeme["name"]
        
        let selectedMemeURL: String = selectedMeme["url"]!
        let url = URL(string: selectedMemeURL)
        
        downloadImage(from: url!)

        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.memeImageView.image = UIImage(data: data)
            }
        }
    }
}

