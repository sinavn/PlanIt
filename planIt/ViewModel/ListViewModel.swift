//
//  ListViewModel.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import Foundation


class ListViewModel : ObservableObject {
    @Published var items : [ItemModel] = []
    
    init() {
        getItems()
    }
    func getItems (){
        let newItems =
        [ItemModel(title: "first item ", isCompleted: false),
        ItemModel(title: "second item", isCompleted: true),
        ItemModel(title: "third item", isCompleted: false)]
        items.append(contentsOf: newItems)
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
}
