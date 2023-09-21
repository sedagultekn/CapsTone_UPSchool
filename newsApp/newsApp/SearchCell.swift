//
//  SearchCell.swift
//  newsApp
//
//  Created by Seda Gültekin on 16.09.2023.
//

import UIKit

protocol TableViewHucreProtocol{
    func haberKaydedildi(indexPath:IndexPath)
    func haberSilindi(indexPath:IndexPath)
}

class SearchCell: UICollectionViewCell {
    var  yıldızlaButtonDeger:Bool = false
    @IBOutlet weak var yıldızlaButton: UIButton!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    var hucreProtocol:TableViewHucreProtocol?
    var indexPath:IndexPath?
    
    func view(){

    }
    @IBAction func savedButtonAct(_ sender: Any) {
       yıldızlaButtonDeger = !yıldızlaButtonDeger
      
       // fetchNewsFromCoreData()
        let cellIdentifier = "uniqueCellIdentifier"
        
        if yıldızlaButtonDeger {
            yıldızlaButton.setImage((UIImage(systemName: "star.fill")), for: .normal)
            hucreProtocol?.haberKaydedildi(indexPath: indexPath!)
        }
        else {
            yıldızlaButton.setImage((UIImage(systemName: "star")), for: .normal)
            hucreProtocol?.haberSilindi(indexPath: indexPath!)
            
           
        }
        
    }
  
}
