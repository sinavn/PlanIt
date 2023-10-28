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
    var body: some Scene {
        let realm = try! Realm()
          WindowGroup {
              ListView(listViewModel: ListViewModel(realm: realm))
                .environment(\.realmConfiguration, Realm.Configuration( /* ... */ ))
          }
      }
    
    
    
//    @EnvironmentObject var listViewModel: ListViewModel
////    @StateObject var listViewModel : ListViewModel = ListViewModel(realm: realm )
//
//    var body: some Scene {
//        let realm = try! Realm()
////        WindowGroup {
//            NavigationView{
//                ListView(listViewModel: ListViewModel(realm: realm))
//            }
//              .environment(\.realmConfiguration, Realm.Configuration( /* ... */ ))
////            .environmentObject(listViewModel)
//        }
//    }
}







