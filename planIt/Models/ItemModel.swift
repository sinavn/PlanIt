//
//  ItemModel.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import Foundation

struct ItemModel:Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    func updateModel ()-> ItemModel{
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
