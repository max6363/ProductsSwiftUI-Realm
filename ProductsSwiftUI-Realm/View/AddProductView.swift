//
//  AddProductView.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import SwiftUI

struct AddProductView: View {
    
    @EnvironmentObject var modelData: DBViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            
            List {
                
                Section(header: Text("Title")) {
                    TextField("", text: $modelData.title)
                }
                
                Section(header: Text("Item Description")) {
                    TextField("", text: $modelData.itemDescription)
                }
                
                Section(header: Text("Price")) {
                    TextField("", text: $modelData.price)
                        .keyboardType(.numberPad)
                }
        
            }
            .navigationTitle("Add Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveProduct()
                    }, label: {
                        Text("Done")
                    })
                }
            }
            .onAppear(perform: {
                modelData.setupInitialData()
            })
            .onDisappear(perform: {
                modelData.deInitData()
            })
        }
    }
    
    private func validateValues() -> Bool {
        
        guard modelData.title != "" else { return false }
        
        guard modelData.itemDescription != "" else { return false }
        
        guard modelData.price != "" else { return false }
        
        return true
    }
    
    private func saveProduct() {
        if validateValues() {
            if modelData.updateProduct == nil {
                addProduct()
            } else {
                updateProduct()
            }
        }
    }
    
    private func addProduct() {
        
        let newProduct = Product()
        newProduct.title = modelData.title
        newProduct.itemDescription = modelData.itemDescription
        newProduct.price = Double(modelData.price) ?? 0.0
        modelData.addData(object: newProduct)
        
        // dismiss view
        presentation.wrappedValue.dismiss()
    }
    
    private func updateProduct() {
        
        guard let updateTo = modelData.updateProduct else { return }
        
        modelData.updateData(object: updateTo)
        
        // dismiss view
        presentation.wrappedValue.dismiss()
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
