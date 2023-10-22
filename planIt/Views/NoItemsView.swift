//
//  NoItemsView.swift
//  planIt
//
//  Created by SinaVN on 7/29/1402 AP.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate : Bool = false
    
    let secondAccentColor = Color("secondAccentColor")
   
    //MARK: - body
    
    var body: some View {
        ScrollView{
            VStack(spacing:20){
                
                Text("there are no items yet!")
                    .font(.title)
                    .fontWeight(.semibold)
               
                Text("add some items if you are a productive person!")
                    .padding(.bottom , 20   )
               
                NavigationLink(destination: AddView() , label: {
                    Text("add new Item 🥳")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(animate ? secondAccentColor : .accentColor )
                        .cornerRadius(10)
                })
                .padding(.horizontal, animate ? 30:50)
                .shadow(color: animate ? secondAccentColor.opacity(0.5) : .accentColor.opacity(0.5),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
                    
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
            
        }
        .frame(maxWidth: .infinity ,maxHeight: .infinity )
    }
    //MARK: - add animation func
    
    func addAnimation (){
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ){
                animate.toggle()
            }
        })
    }
}
//MARK: - preview


struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoItemsView()
        }
    }
}
