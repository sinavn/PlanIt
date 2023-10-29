////
////  cgpt.swift
////  planIt
////
////  Created by SinaVN on 7/28/1402 AP.
////
//
//import Foundation
////To implement Realm on a todo list app that is written on SwiftUI, follow these steps:
////
////1. Add the RealmSwift framework to your Xcode project by going to File > Swift Packages > Add Package Dependency and searching for RealmSwift.
////
////2. Create a new file called "TodoItem.swift" and define a TodoItem class that extends Object. This class will represent a single todo item in your app.
//
//
//import RealmSwift
//
//class TodoItem: Object {
//    @objc dynamic var id = UUID().uuidString
//    @objc dynamic var title = ""
//    @objc dynamic var isCompleted = false
//
//    override static func primaryKey() -> String? {
//        return "id"
//    }
//}
//
//
////3. Create a new file called "TodoListViewModel.swift" and define a TodoListViewModel class that will handle interactions with the Realm database. This class will have a property called "items" that will hold the list of todo items.
//
//
//import RealmSwift
//
//class TodoListViewModel: ObservableObject {
//    @Published var items: Results<TodoItem>
//
//    private var realm: Realm
//
//    init(realm: Realm) {
//        self.realm = realm
//        self.items = realm.objects(TodoItem.self)
//    }
//
//    func addItem(title: String) {
//        try! realm.write {
//            let newItem = TodoItem()
//            newItem.title = title
//            realm.add(newItem)
//        }
//    }
//
//    func toggleItemCompletion(item: TodoItem) {
//        try! realm.write {
//            item.isCompleted.toggle()
//        }
//    }
//
//    func deleteItem(item: TodoItem) {
//        try! realm.write {
//            realm.delete(item)
//        }
//    }
//}
//
//
////4. In your SwiftUI view file, create an instance of the TodoListViewModel and pass it to your view as an environment object.
////
//
//struct TodoListView: View {
//    @EnvironmentObject var viewModel: TodoListViewModel
//
//    var body: some View {
//        // ...
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        let realm = try! Realm()
//        let viewModel = TodoListViewModel(realm: realm)
//
//        return TodoListView()
//            .environmentObject(viewModel)
//    }
//}
//
//
////5. In your view, use the items property of the TodoListViewModel to display the list of todo items.
//
//
//struct TodoListView: View {
//    @EnvironmentObject var viewModel: TodoListViewModel
//
//    var body: some View {
//        List(viewModel.items) { item in
//            HStack {
//                Text(item.title)
//                Spacer()
//                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(.blue)
//                    .onTapGesture {
//                        viewModel.toggleItemCompletion(item: item)
//                    }
//            }
//        }
//    }
//}
//
//
////6. Use the addItem and deleteItem methods of the TodoListViewModel to add and remove items from the list.
//
//
//struct TodoListView: View {
//    @EnvironmentObject var viewModel: TodoListViewModel
//    @State private var newItemTitle = ""
//
//    var body: some View {
//        VStack {
//            TextField("Add new item", text: $newItemTitle, onCommit: {
//                viewModel.addItem(title: newItemTitle)
//                newItemTitle = ""
//            })
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            .padding()
//
//            List(viewModel.items) { item in
//                HStack {
//                    Text(item.title)
//                    Spacer()
//                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(.blue)
//                        .onTapGesture {
//                            viewModel.toggleItemCompletion(item: item)
//                        }
//                }
//            }
//
//            Button(action: {
//                if let lastItem = viewModel.items.last {
//                    viewModel.deleteItem(item: lastItem)
//                }
//            }, label: {
//                Text("Delete last item")
//            })
//        }
//    }
//}
//
//
////That's it! You now have a todo list app that uses Realm to store and manage your todo items.










//import SwiftUI
//import RealmSwift
//
//struct ItemModel: Identifiable {
//    @objc dynamic var id = UUID().uuidString
//    @objc dynamic var title: String = ""
//}
//
//class ListViewModel: ObservableObject {
//    @Published var items: Results<ItemModel>
//    private var realm: Realm
//    private var notificationToken: NotificationToken?
//
//    init(realm: Realm) {
//        self.realm = realm
//        self.items = realm.objects(ItemModel.self)
//
//        notificationToken = items.observe { [weak self] _ in
//            self?.objectWillChange.send()
//        }
//    }
//
//    func addItem(title: String) {
//        let newItem = ItemModel()
//        newItem.title = title
//
//        do {
//            try realm.write {
//                realm.add(newItem)
//            }
//        } catch {
//            print("Error adding item: \(error)")
//        }
//    }
//
//    func updateItem(item: ItemModel) {
//        do {
//            try realm.write {
//                item.title += " updated"
//            }
//        } catch {
//            print("Error updating item: \(error)")
//        }
//    }
//
//    func deleteItem(item: ItemModel) {
//        do {
//            try realm.write {
//                realm.delete(item)
//            }
//        } catch {
//            print("Error deleting item: \(error)")
//        }
//    }
//
//    func moveItem(from source: IndexSet, to destination: Int) {
//        do {
//            try realm.write {
//                items.move(fromOffsets: source, toOffset: destination)
//            }
//        } catch {
//            print("Error moving item: \(error)")
//        }
//    }
//
//    deinit {
//        notificationToken?.invalidate()
//    }
//}
//
//struct ListView: View {
//    @EnvironmentObject var listViewModel: ListViewModel
//
//    var body: some View {
//        List {
//            ForEach(listViewModel.items) { item in
//                ListRowView(item: item)
//                    .onTapGesture {
//                        withAnimation(.linear){
//                            listViewModel.updateItem(item: item)
//                        }
//                    }
//            }
//            .onDelete { indexSet in
//                for index in indexSet {
//                    let item = listViewModel.items[index]
//                    listViewModel.deleteItem(item: item)
//                }
//            }
//            .onMove { indexSet, newIndex in
//                listViewModel.moveItem(from: indexSet, to: newIndex)
//            }
//        }
//        .listStyle(.plain)
//        .navigationTitle("plan It 📝")
//        .navigationBarItems(leading: EditButton(), trailing:
//            NavigationLink("add", destination: AddView())
//        )
//    }
//}
//
//struct AddView: View {
//    @State private var title = ""
//    @EnvironmentObject var listViewModel: ListViewModel
//
//    var body: some View {
//        Form {
//            Section(header: Text("Title")) {
//                TextField("Enter title", text: $title)
//            }
//
//            Button(action: addItem) {
//                Text("Add")
//            }
//        }
//        .navigationBarTitle("Add Item")
//    }
//
//    func addItem() {
//        listViewModel.addItem(title: title)
//    }
//}
//
//struct ListRowView: View {
//    let item: ItemModel
//
//    var body: some View {
//        Text(item.title)
//    }
//}
//
//struct ContentView: View {
//    let realm = try! Realm()
//
//    var body: some View {
//        NavigationView {
//            ListView()
//                .environmentObject(ListViewModel(realm: realm))
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
