//
//  ContentView.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 08/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        TabView{
            if listViewModel.items.isEmpty{
                Text("no data !!!")
            }else {
                List{
                    ForEach(listViewModel.items)
                    { item in ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .tabItem {
                    Image(systemName: "iphone")
                    Text("phone")
                }
                
                Color.green.tabItem {
                    Image(systemName: "server.rack")
                    Text("server")
                }
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("more")
        .navigationBarItems(
            leading: Text("mochamad rizky reynaldy"),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ListViewModel())
    }
}
