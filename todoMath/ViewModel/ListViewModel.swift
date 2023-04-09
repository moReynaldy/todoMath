//
//  ListViewModel.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 08/04/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase
import FirebaseDatabaseSwift

struct DbMath: Identifiable, Codable{
    var id: String = UUID().uuidString
    var title: String
    var isCompleted: Bool
}

class ListViewModel: ObservableObject {
    private var dbRef = Firestore.firestore().collection("math")
        
    @Published var items: [ItemModel] = [] {
        didSet{
            saveItems()
        }
    }
    
    @Published var DbMat : [DbMath] = []
    
    let itemsKey: String = "items_list"
    
    init(){
        getItems()
        fetchDataServer()
    }
    
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data) else {return}
        
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
        
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func addServer(title: String){
        do {
            try dbRef.addDocument(data: ["title": title]).setData(from: title, encoder: encoder)
        } catch _ { return }
    }
    
    func fetchDataServer(){
        dbRef.addSnapshotListener{ (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {return}
        
            self.DbMat = documents.map{ queryDocumentSnapshot -> DbMath in
                let data = queryDocumentSnapshot.data()
                let title = data["title"] as? String ?? ""
                let isCompleted = data["isCompleted"] as? Bool ?? false
                return DbMath(id: .init(), title: title, isCompleted: isCompleted)
                
            }
        }
    }
}
