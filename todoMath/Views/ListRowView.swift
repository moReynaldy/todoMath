//
//  ListRowView.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 09/04/23.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
        .font(.title)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "first item !!!", isCompleted: true)
    static var previews: some View {
        ListRowView(item: item1)
    }
}
