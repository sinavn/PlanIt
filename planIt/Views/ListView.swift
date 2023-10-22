//
//  ListView.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel :ListViewModel
    
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty{
                NoItemsView()
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
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                    
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
        NavigationView{
            ListView()
            
        }
        .environmentObject(ListViewModel())
    }
}

