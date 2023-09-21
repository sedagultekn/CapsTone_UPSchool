//
//  KaydedilenlerCell.swift
//  newsApp
//
//  Created by Seda Gültekin on 19.09.2023.
//

import Foundation
import UIKit
protocol KaydedilenTableViewHucreProtocol{
   
    func haberSilindi(indexPath:IndexPath)
}
class KaydedilenlerCell:UITableViewCell{
    @IBOutlet weak var kaydedilenImage: UIImageView!
    @IBOutlet weak var kaydedilenLabel: UILabel!
  
    @IBOutlet weak var yildizlananButton: UIButton!
    var  yıldızlaButtonDeger:Bool = false
    var hucreProtocol:KaydedilenTableViewHucreProtocol?
    var indexPath:IndexPath?
    
    @IBAction func kaydedilenButton(_ sender: Any)
    {
       yıldızlaButtonDeger = !yıldızlaButtonDeger
      
       // fetchNewsFromCoreData()
        let cellIdentifier = "uniqueCellIdentifier"
        
        if yıldızlaButtonDeger {
            yildizlananButton.setImage((UIImage(systemName: "star")), for: .normal)
        }
        else {
            yildizlananButton.setImage((UIImage(systemName: "star.fill")), for: .normal)
            hucreProtocol?.haberSilindi(indexPath:indexPath!)
            print("star")

           
        }
        
    }
}
