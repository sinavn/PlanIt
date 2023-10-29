//
//  ListViewModel.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import Foundation
import RealmSwift

class ListViewModel:ObservableObject{
    
    @Published var items : Results<ItemModel>
//    {
//        didSet{
//            listItems.append(objectsIn: items)
//        }
//    }
    
//    @Published var listItems = List<ItemModel>()
    
    private var realm: Realm
    
    private var notificationToken: NotificationToken?
    
//    private var allItems :Results<ItemModel>
    init() {
        realm = try! Realm()
        
//       let itemss = realm.objects(ItemModel.self)
//        items.append(objectsIn: itemss)
        
        items = realm.objects(ItemModel.self)

        notificationToken = items.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
        
    }
    //MARK: - CRUD
    

    func addItem(title: String) {
        let newItem = ItemModel()
        newItem.title = title
        
        do {
            try realm.write {
                realm.add(newItem)
            }
            objectWillChange.send()
        } catch {
            print("Error adding item: \(error)")
        }
    }
    
    
    func updateItem(item: ItemModel) {
        do {
            try realm.write {
                item.isCompleted.toggle()
            }
            objectWillChange.send()
        } catch {
            print("Error updating item: \(error)")
        }
    }
    
    
    func deleteItem(item: ItemModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
            objectWillChange.send()
        } catch {
            print("Error deleting item: \(error)")
        }
    }
    
//        func moveItem(from source: IndexSet, to destination: Int) {
//            do {
//                try realm.write {
//                    items.move(fromOffsets: source, toOffset: destination)
//
//                }
//            } catch {
//                print("Error moving item: \(error)")
//            }
//        }
//
    deinit {
           notificationToken?.invalidate()
       }
}


