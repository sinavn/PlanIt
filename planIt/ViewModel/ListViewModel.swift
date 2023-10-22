//
//  ListViewModel.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import Foundation


class ListViewModel : ObservableObject {
    @Published var items : [ItemModel] = []{
        didSet{
            saveItem()
        }
    }
    
    let itemsKey :String = "items_list"
    init() {
        getItems()
    }
    func getItems (){ 
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItem = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {return}
        self.items = savedItem
    }
    //MARK: - CRUD
    func deleteItem(indexSet : IndexSet){
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from:IndexSet , to:Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    func addItem (title : String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    func updateItem(item :ItemModel){
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateModel()
       }
    }
    func saveItem(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
