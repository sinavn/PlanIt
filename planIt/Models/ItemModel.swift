//
//  ItemModel.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import Foundation
import RealmSwift

class ItemModel: Object , ObjectKeyIdentifiable  {
    @Persisted var id = UUID().uuidString
    @Persisted var title = ""
    @Persisted var isCompleted = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

