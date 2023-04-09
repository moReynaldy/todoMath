//
//  AddView.swift
//  todoMath
//
//  Created by mochamad rizky reynaldy on 08/04/23.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFieldText: String = ""
    @State var textFieldText2: String = ""
    @State var alertTitle: String = ""
    @State var toogleIsOn: Bool = false
    @State var showAlert: Bool = false
    
    var body: some View {
        
        ScrollView{
        VStack(spacing: 20){
                HStack{
                    TextField("input number", text: $textFieldText)
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(.red)
                        .cornerRadius(10)
                    
                    TextField("input number", text: $textFieldText2)
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.3).cornerRadius(10))
                        .foregroundColor(.red)
                        .cornerRadius(10)
                }
                
                Toggle(isOn: $toogleIsOn,
                    label: {
                    Text("save data to ?")
                    Text(toogleIsOn ? "server" : "phone")
                })
                
            Button(action: toogleIsOn ? saveButtonServerPressed : saveButtonPhonePressed , label: {
                Text("submit".uppercased())
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            })
                
            }.padding(32)
        }
        .navigationTitle("simple calculate math")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
    }
    
    func textIsAppropriate()-> Bool{
        if textFieldText.count < 1 {
            alertTitle = "you need to put number at least 1 number"
            
            showAlert.toggle()
            return false
        }else if textFieldText2.count < 1 {
            alertTitle = "you need to put number at least 2 number"
            
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func saveButtonPhonePressed(){
        let num1 = Int(textFieldText) ?? 0
        let num2 = Int(textFieldText2) ?? 0
        
        let p = num1 + num2
        let p2 = num1 - num2
        let p3 = num1 * num2
        let p4 = num1 / num2
        
        if textIsAppropriate(){
            listViewModel.addItem(title: "penjumlahan : \(textFieldText) + \(textFieldText2) = \(p) pengurangan : \(textFieldText) - \(textFieldText2) = \(p2) perkalian : \(textFieldText) * \(textFieldText2) = \(p3) pembagian : \(textFieldText) / \(textFieldText2) = \(p4)")
        }
        
        presentationMode.wrappedValue.dismiss()
    }

    func saveButtonServerPressed(){
        let num1 = Int(textFieldText) ?? 0
        let num2 = Int(textFieldText2) ?? 0
        
        let p = num1 + num2
        let p2 = num1 - num2
        let p3 = num1 * num2
        let p4 = num1 / num2
        
        if textIsAppropriate(){
            listViewModel.addServer(title: "penjumlahan : \(textFieldText) + \(textFieldText2) = \(p) pengurangan : \(textFieldText) - \(textFieldText2) = \(p2) perkalian : \(textFieldText) * \(textFieldText2) = \(p3) pembagian : \(textFieldText) / \(textFieldText2) = \(p4)")
        }
        
        presentationMode.wrappedValue.dismiss()
    }

}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ListViewModel())
    }
}
