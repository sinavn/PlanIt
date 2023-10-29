//
//  planItApp.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

//import RealmSwift
import SwiftUI
import RealmSwift

@main
struct planItApp: SwiftUI.App {
    let realm = try! Realm()
        
    @StateObject var listViewModel : ListViewModel = ListViewModel( )

    var body: some Scene {
        
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
//






