//
//  KaydedilenlerViewModel.swift
//  newsApp
//
//  Created by Seda Gültekin on 21.09.2023.
//

import Foundation
import UIKit
import CoreData

class KaydedilenlerViewModel {
     var newsData: [NSManagedObject] = []
    

    func fetchDataFromCoreData(completion: @escaping ([NSManagedObject]?) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Kaydedilenler")
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            completion(results)
        } catch {
            print("Veri çekme hatası: \(error.localizedDescription)")
            completion(nil)
        }
    }

    func deleteNewsFromCoreData(_ haber: NSManagedObject, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext

        managedContext.delete(haber)

        do {
            try managedContext.save()
            completion(true)
        } catch {
            print("Veri silme hatası: \(error.localizedDescription)")
            completion(false)
        }
    }

    func numberOfRows() -> Int {
        return newsData.count
    }

    func newsAtIndex(_ index: Int) -> NSManagedObject? {
        guard index >= 0, index < newsData.count else {
            return nil
        }
        return newsData[index]
    }
}
