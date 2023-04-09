//
//  ListRowViewServer.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 10/04/23.
//

import SwiftUI

struct ListRowViewServer: View {
    let item: DbMath
    
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

struct ListRowViewServer_Previews: PreviewProvider {
    static var item1 = DbMath(title: "first item !!!", isCompleted: true)
    
    static var previews: some View {
        ListRowViewServer(item: item1)
    }
}
