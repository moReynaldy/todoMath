//
//  todoMathApp.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 08/04/23.
//

import SwiftUI
import Firebase

@main
struct todoMathApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(listViewModel)
        }
    }
}
