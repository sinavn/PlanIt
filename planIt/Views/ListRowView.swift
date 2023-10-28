//
//  ListRowView.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//
import SwiftUI

struct ListRowView: View {
    
    @State var item: ItemModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle":"circle")
                .foregroundColor(item.isCompleted ? .green :.red)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical , 8)
    }
}
//MARK: - preview



struct ListRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group{
            ListRowView(item: ItemModel()
            )
            
            .previewLayout(.sizeThatFits)
            
        }
        
    }
}
