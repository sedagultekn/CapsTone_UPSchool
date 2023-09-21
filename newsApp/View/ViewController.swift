//
//  ViewController.swift
//  newsApp
//
//  Created by Seda Gültekin on 6.09.2023.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var nextButtonCount = 0
    var slides: [OnBoardingSlide] = []
    var currentpage = 0{
        didSet{
            pageControl.currentPage = currentpage
            if currentpage == slides.count-1 {
                nextButton.setTitle("Get Started", for: .normal)
                nextButtonCount = 1
            }else{
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         slides = [
             OnBoardingSlide(title: "KEŞFEDİN", description: "En güncel ve çeşitli haberleri keşfedin.", image:(UIImage(named: "gazete1"))!),
             OnBoardingSlide(title: "KİŞİSELLEŞTİRİN", description: "Kişiselleştirilmiş haber akışınızı oluşturun.", image: (UIImage(named: "gazete2"))!),
             OnBoardingSlide(title: "Haberler", description: "Tüm önemli gelişmelerden anında haberdar olun.", image: (UIImage(named: "gazete3"))!)
         
         ]
         collectionView.dataSource = self
         collectionView.delegate = self
    }

    @IBAction func nextBtn(_ sender: Any) {
        if nextButtonCount != 1{
            currentpage += 1
            let indexPath = IndexPath(item: currentpage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        else {
            let storyboard: UIStoryboard = UIStoryboard(name: "login+register", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
// MARK: - CollectionView
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCollectionViewCell", for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let widht = scrollView.frame.width
        currentpage = Int(scrollView.contentOffset.x/widht)
      
    }
}
