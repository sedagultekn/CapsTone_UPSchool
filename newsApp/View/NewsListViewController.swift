//
//  NewsListViewController.swift
//  newsApp
//
//  Created by Seda Gültekin on 13.09.2023.
//

import UIKit
import CoreData
class NewsListViewController: UIViewController {
    var mySideMenu = false
    var  news = [Article]()
    var categories:String = "general"
    var yildizlananHaber=[Int:Bool]()
    var kaydedilen: [Kaydedilenler] = []
    var filteredData: [String] = []
    var optionalValue: Optional<Any>?
    func getUrl(categories:String)->String{
        "https://newsapi.org/v2/everything?q=\(self.categories)&apiKey=9c2599ed481540eabb89e3ee3a6df327"
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        prepareCollectionView()
        prepareSearchBar()
        prepareNavigationBar()
        newsCollectionView.backgroundColor = UIColor.clear
        
        }
    
           
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        getNews()
    }
    func prepareNavigationBar() {
    
        title = "News"
    }

    
    func prepareSearchBar(){

    }
    func prepareCollectionView(){
        newsCollectionView.delegate=self
        newsCollectionView.dataSource=self
    }
    func hiddenMenu(){
        leadingConstraint.constant = -284
        UIView.animate(withDuration: 0.3, delay: 0.1,options: .curveEaseIn,animations: { [self] in
            self.view.layoutIfNeeded()
            getNews()
            self.newsCollectionView.reloadData()
        })
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        if (mySideMenu){
         hiddenMenu()
            

        }else{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0.1,options: .curveEaseIn,animations: {
                self.view.layoutIfNeeded()
            })
          
            }
        mySideMenu = !mySideMenu
    }
    
    @IBAction func suports(_ sender: Any) {
    categories = "suports"
    hiddenMenu()
        
    }
    @IBAction func business(_ sender: Any) {
    categories = "business"
      hiddenMenu()
    }
    
    @IBAction func entertainment(_ sender: Any) {
    categories = "entertainment"
     hiddenMenu()
    }
    @IBAction func health(_ sender: Any) {
    categories = "health"
       hiddenMenu()
        
    }
    
    @IBAction func sience(_ sender: Any) {
    categories = "sience"
      hiddenMenu()
    
    }
    @IBAction func technology(_ sender: Any) {
   hiddenMenu()
    
    }
    
    @IBAction func general(_ sender: Any) {
    categories = "general"
    hiddenMenu()
        newsCollectionView.reloadData()
    }
    func getNews(){
        if let url = URL(string: getUrl(categories:categories)){
            NetworkManager.shared.fetchNews(url: url, completion: { news in
                self.news=news
                DispatchQueue.main.async {
                    self.newsCollectionView.reloadData()
                  //  self.collectionView2.reloadData()
                }
                
            }
            )
        }
    }

}
extension NewsListViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String)
    {
       categories=searchText
       
        if searchText == ""{
            categories = "general"
        }
        getNews()
        newsCollectionView.reloadData()
    }
}
extension NewsListViewController: UICollectionViewDelegate,UICollectionViewDataSource,TableViewHucreProtocol{
    func haberSilindi(indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          let managedContext = appDelegate.persistentContainer.viewContext
          let entity = NSEntityDescription.entity(forEntityName: "Kaydedilenler", in: managedContext)!
        do {
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Kaydedilenler")
            request.predicate = NSPredicate(format: "title == %@", news[indexPath.row].title!)
                    let fetchResult = try managedContext.fetch(request)

                    for data in fetchResult as! [NSManagedObject]{
                        managedContext.delete(data)
                        appDelegate.saveContext()
                    }
                    appDelegate.saveContext()
                } catch {
                    print(error.localizedDescription)
                }
    }
    
    func haberKaydedildi(indexPath: IndexPath) {
        
        print("\(news[indexPath.item].title)")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          let managedContext = appDelegate.persistentContainer.viewContext
          let entity = NSEntityDescription.entity(forEntityName: "Kaydedilenler", in: managedContext)!
          
         
        let haber = NSManagedObject(entity: entity, insertInto: managedContext)
        haber.setValue(news[indexPath.item].title, forKey: "title")
        haber.setValue(news[indexPath.item].urlToImage, forKey: "image")
        haber.setValue(news[indexPath.item].description, forKey: "descrption")
        haber.setValue(true,forKey: "isSaved")
          do {
              try managedContext.save()
              print("Haber Core Data'ya başarıyla kaydedildi: \(String(describing: news[indexPath.item].title))")
              print("Haber Core Data'ya başarıyla kaydedildi: \(String(describing: news[indexPath.item].urlToImage))")
              print("Haber Core Data'ya başarıyla kaydedildi: \(String(describing: news[indexPath.item].description))")
          } catch let error as NSError {
              print("Haber kaydetme hatası: \(error), \(error.userInfo)")
          }
        
    }
        

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            collectionView == self.newsCollectionView
                return news.count
            
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as! SearchCell
      
        cell.newsTitleLabel.text = news[indexPath.item].title
            if let urlToImage = news[indexPath.row].urlToImage {
                if let url = URL(string: urlToImage) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                cell.newsImageView.image = UIImage(data: data)
                            }
                        }
                    }
                }
            }
        cell.hucreProtocol=self
        cell.indexPath=indexPath
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.brown.cgColor
        cell.layer.cornerRadius = 20
        
       
        return cell
        
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.newsContent = news[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
      }
        
    
        }
   

        
        


    
    
    

    
    
