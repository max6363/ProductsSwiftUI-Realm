//
//  AddProductView.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import SwiftUI

struct AddProductView: View {
    
    @State var selectedCategory: Kind = .Others
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
                
                Section(header: Text("Category")) {
                    Picker(selection: $modelData.category, label: Text("Choose category")) {
                        ForEach(Array(Kind.allCases), id:\.self) { category in
                            Text(category.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
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
        newProduct.category?.name = modelData.category.rawValue        
        newProduct.photos.append("https://source.unsplash.com/user/c_v_r/1900x800")
        newProduct.photos.append("https://dummyimage.com/300/09f/fff.png")
        newProduct.photos.append("https://dummyimage.com/300/09f/fff.png")
        newProduct.photos.append("https://dummyimage.com/300/09f/fff.png")
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
