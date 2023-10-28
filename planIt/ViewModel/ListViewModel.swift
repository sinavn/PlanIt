//
//  ListViewModel.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import Foundation
import RealmSwift

class ListViewModel :ObservableObject {
    @Published var items : Results<ItemModel>
   
    private var realm :Realm
    
    init(realm : Realm){
        self.realm = realm
        self.items = realm.objects(ItemModel.self)
    }
    //MARK: - CRUD
    

    func addItem (item : String){
        try! realm.write{
            let newItem = ItemModel()
            newItem.title = item
            realm.add(newItem)
        }
    }
    
    func deleteItem (item : ItemModel){
        try! realm.write{
            realm.delete(item)
        }
    }
    func updateItem (item : ItemModel){
        try! realm.write{
            item.isCompleted.toggle()
        }
    }
    func moveItem(from:IndexSet , to: Int){
        try! realm.write{
           moveItem(from: from, to: to)
        }
    }
    
    
}










//class ListViewModel : ObservableObject {
//    @Published var items : [ItemModel] = []
//
//    init() {
//        getItems()
//    }
//    func getItems (){
//        let newItems =
//        [ItemModel(title: "first item ", isCompleted: false),
//        ItemModel(title: "second item", isCompleted: true),
//        ItemModel(title: "third item", isCompleted: false)]
//        items.append(contentsOf: newItems)
//    }
//    //MARK: - CRUD
//    func deleteItem(indexSet : IndexSet){
//        items.remove(atOffsets: indexSet)
//    }
//    func moveItem(from:IndexSet , to:Int){
//        items.move(fromOffsets: from, toOffset: to)
//    }
//    func addItem (title : String){
//        let newItem = ItemModel(title: title, isCompleted: false)
//        items.append(newItem)
//    }
//    func updateItem(item :ItemModel){
//        if let index = items.firstIndex(where: {$0.id == item.id}){
//            items[index] = item.updateModel()
//       }
//    }
//}
