//
//  ListView.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import SwiftUI
import RealmSwift

struct ListView: View {
    @EnvironmentObject var listViewModel : ListViewModel
    
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty{
                NoItemView()
            
            }else{
                List{
                    ForEach(listViewModel.items ) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }

                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet{
                           let item = listViewModel.items[index]
                            listViewModel.deleteItem(item: item)
                        }
                    })
        //            .onMove { indexSet, newIndex in
        //                listViewModel.moveItem(from: indexSet, to: newIndex)
        //            }
                    
                    
                }
           
            }
        }
        .listStyle(.plain)
        .navigationTitle("plan It 📝")
        .navigationBarItems(leading: EditButton(), trailing:
        NavigationLink("add", destination: AddView())
        )
       
          
        
       

    }
   
}
//MARK: - preview

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
//        let realm = try! Realm()
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}

