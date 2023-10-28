//
//  AddView.swift
//  planIt
//
//  Created by SinaVN on 7/27/1402 AP.
//
import SwiftUI
import RealmSwift

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel : ListViewModel
    @State var textFieldText :String = ""
    
    @State var alertTitle :String = ""
    @State var showAlert : Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("add something", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
                
                Button(action: saveButtonPressed, label: {
                    Text("save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55 )
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(15    )
                       
                })
            }
            .padding(14)
            .alert(isPresented: $showAlert, content: getAlert )
        }
        .navigationTitle("add item ✏️")
    }
    
    func saveButtonPressed(){
        if textIsAppropriate(){
            listViewModel.addItem(item: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        
        
    }
    func textIsAppropriate () -> Bool{
        if textFieldText.count < 3{
            alertTitle = "your new todo item must be at least 3 charecters 😔"
            showAlert.toggle()
            return false
        }
        return true
    }
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
    }
}

//MARK: - preview

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        let realm = try! Realm()
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel(realm: realm))
    }
}
