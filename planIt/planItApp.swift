//
//  planItApp.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import SwiftUI

@main
struct planItApp: App {
    
    @StateObject var listViewModel : ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
