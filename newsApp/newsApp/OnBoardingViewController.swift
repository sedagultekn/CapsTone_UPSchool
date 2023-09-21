//
//  onBoardingViewController.swift
//  newsApp
//
//  Created by Seda Gültekin on 9.09.2023.
//

import UIKit

class OnBoardingViewController: UIViewController {

 
    
 
    var slides: [OnBoardingSlide] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* slides = [
            OnBoardingSlide(title: "hktlrefdl", description: "dkfjrftlbklre", image:(UIImage(named: "aslan"))!),
            OnBoardingSlide(title: "vjfldkeslk", description: "lrlefkdwlkf", image: (UIImage(named: "aslan"))!),
            OnBoardingSlide(title: "vojbgtlfdekw", description: "lrvmjvlekc", image: (UIImage(named: "aslan"))!)
        
        ]*/
      //  collectionView.dataSource = self
      //  collectionView.delegate = self
    }
    

    @IBAction func nextButtonAction(_ sender: Any) {
    }
    

}
/*extension OnBoardingViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
}
*/
