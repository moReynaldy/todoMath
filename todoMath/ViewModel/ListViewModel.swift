//
//  ListViewModel.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 08/04/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class ListViewModel: ObservableObject {
    private var dbRef = Firestore.firestore().collection("math")
    
    @Published var items: [ItemModel] = [] {
        didSet{
            saveItems()
        }
    }
    
    
        
    let itemsKey: String = "items_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {return}
        
        self.items = savedItems
    }
    
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updateCompletion()
        }
    }
    
    func addServer(title: String){
        dbRef.addDocument(data: ["title": title])
    }
    


}
