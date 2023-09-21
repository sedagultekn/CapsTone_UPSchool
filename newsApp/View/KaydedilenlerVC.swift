//
//  KaydedilenlerVC.swift
//  newsApp
//
//  Created by Seda Gültekin on 19.09.2023.
//

import UIKit
import CoreData

class KaydedilenlerVC: UIViewController {
 
    var newsData: [NSManagedObject] = []
    var indexPathToDelete = IndexPath(row: 0, section: 0)
   var newsContent2:Article=Article(author: "", title: "", description: "", url: "", urlToImage: "", content: "")

    @IBOutlet weak var kaydedilenlerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavigationBar()
        tableViewDelgateDataSource()
        kaydedilenlerTableView.dataSource = self
            kaydedilenlerTableView.delegate = self
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        kaydedilenlerTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        kaydedilenlerTableView.reloadData()
    
    }
//    func loadImage(){
//
//            if let url = URL(string: urlToImage) {
//                DispatchQueue.global().async {
//                    if let data = try? Data(contentsOf: url) {
//                        DispatchQueue.main.async {
//                            cell.newsImageView.image = UIImage(data: data)
//                        }
//                    }
//                }
//            }
//    }
   
    func prepareNavigationBar() {
       // navigationController?.navigationBar.prefersLargeTitles = true
        title = "Saved"
    }

    func tableViewDelgateDataSource() {
    
        DispatchQueue.main.async {
            self.kaydedilenlerTableView.reloadData()
          //  self.collectionView2.reloadData()
        }
    }
    
    func fetchNewsFromCoreData() -> [NSManagedObject]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Kaydedilenler")
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            return results
        } catch {
            print("Veri çekme hatası: \(error.localizedDescription)")
            return nil
        }
    }
    func deleteNewsFromCoreData(_ haber: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(haber)
        
        do {
            try managedContext.save()
        } catch {
            print("Veri silme hatası: \(error.localizedDescription)")
        }
    }
    


}
extension KaydedilenlerVC:UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,KaydedilenTableViewHucreProtocol {
    func haberSilindi(indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Kaydedilenler")
        fetchRequest.predicate = NSPredicate(format: "title == %@",title!) // Sileceğiniz verinin başlığına göre koşul belirleyin
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                managedContext.delete(object as! NSManagedObject)
            }
            try managedContext.save()
            print("Haber Core Data'dan başarıyla silindi: \(title)")
            
        } catch let error as NSError {
            print("Haber silme hatası: \(error), \(error.userInfo)")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Silinecek veriye eriş ve silme işlemini gerçekleştir
            // Örneğin, Core Data'dan veriyi silme veya veri kaynağından silme işlemleri yapılabilir
            
            // Örnek olarak, Core Data'dan haber verisini alıp silme işlemini gerçekleştirme
            if let newsData = fetchNewsFromCoreData() {
                let haber = newsData[indexPath.row]
                deleteNewsFromCoreData(haber) // Bu fonksiyonu Core Data'dan veri silmek için kullanabilirsin
            }
            
            // TableView'dan hücreyi silme
            kaydedilenlerTableView.deleteRows(at: [indexPath], with: .fade)
            
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let newsData = fetchNewsFromCoreData() {
            return newsData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kaydedilenCell = tableView.dequeueReusableCell(withIdentifier: "KaydedilenlerCell", for: indexPath) as! KaydedilenlerCell
        //        if let result = fetchNewsFromCoreData() {
        //            // Silmek istediğiniz öğeyi seçin (result bir NSManagedObject dizisi olmalıdır)
        //            let objectToDelete = result[indexPath.row]
        //
        //            // Veriyi silme işlemini çağırın
        //            deleteRecord(object: objectToDelete)
        //
        //            // TableView'i yeniden yüklemeyi unutmayın
        //            tableView.reloadData()
        //        }
        if let newsData = fetchNewsFromCoreData() {
            let haber = newsData[indexPath.row]
            if let title = haber.value(forKey: "title") as? String {
                kaydedilenCell.kaydedilenLabel.text = title
                // KaydedilenlerTableView.reloadData()
                if let imageUrlString = haber.value(forKey: "image") as? String,
                   let imageUrl = URL(string: imageUrlString) {
                    // URL'yi kullanarak resmi asenkron bir şekilde indirin ve gösterin
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: imageUrl) {
                            DispatchQueue.main.async {
                                kaydedilenCell.kaydedilenImage.image = UIImage(data: data)
                            }
                        }
                    }
                }
                
                
            }}
        kaydedilenCell.layer.borderWidth = 1
        kaydedilenCell.layer.borderColor = UIColor.orange.cgColor
        kaydedilenCell.layer.cornerRadius = 20
        
        return kaydedilenCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let newsData = fetchNewsFromCoreData() {
            let haber = newsData[indexPath.row]

            if let title = haber.value(forKey: "title") as? String,
               let description = haber.value(forKey: "description") as? String,
               let url = haber.value(forKey: "url") as? String,
               let urlToImage = haber.value(forKey: "image") as? String,
               let content = haber.value(forKey: "content") as? String {
                   let newsContent2 = Article(author: "", title: title, description: description, url: url, urlToImage: urlToImage, content: content)

                   let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
                   navigationController?.pushViewController(vc, animated: true)
            }
        }

                   // DetailVC'ye veriyi ileterek geçiş yapın
//                   let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
//                   navigationController?.pushViewController(vc, animated: true)
//                   vc.newsContent = newsContent
                
            }
        }
    

        
        

