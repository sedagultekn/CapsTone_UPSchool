//
//  DetailVC.swift
//  newsApp
//
//  Created by Seda Gültekin on 18.09.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsLabel: UILabel!
    var newsContent:Article=Article(author: " ", title: " ", description: " ", url: " ", urlToImage: " ", content: " ")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTitle.text = newsContent.title
        newsLabel.text=newsContent.description
        if newsContent.urlToImage != nil {
            //  newsImage.image = newsContent.urlToImage
            if let urlToImage = newsContent.urlToImage {
                if let url = URL(string: urlToImage) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.newsImage.image = UIImage(data: data)
                                
                            }
                        }
                        
                        
                        
                        
                    }
                }}}}}
