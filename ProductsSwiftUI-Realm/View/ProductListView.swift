//
//  ProductListView.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 08/12/21.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var sortingOption = "Title"
    var options = ["Date Added", "Title", "Price"]
    
    @State private var sortingOrder = "Ascending"
    var sortingOptions = ["Ascending", "Descending"]
    
    @StateObject var modelData = DBViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(modelData.products) { product in
                        ProductItemRow(product: product)
                            .onTapGesture {

                                modelData.title = product.title
                                modelData.itemDescription = product.itemDescription
                                modelData.price = "\(product.price)"
                                modelData.updateProduct = product
                                modelData.openNewProduct.toggle()
                            }
                    }
                    .onDelete { indexSet in
                        deleteProducts(at: indexSet)
                    }
                }
                .listRowSeparator(.hidden)
                
                HStack {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Sorting by")
                                .font(.system(size: 10, weight: .light, design: .default))
                                .padding(0)
                            Picker("Sort", selection: $sortingOption) {
                                ForEach(options, id:\.self) {
                                    Text($0)
                                }
                            }
                            .padding(0)
                            .onChange(of: sortingOption) { option in

                                switch option {
                                case "Date Added":
                                    modelData.sortBy = .dateAdded
                                case "Title":
                                    modelData.sortBy = .title
                                case "Price":
                                    modelData.sortBy = .price
                                default:
                                    modelData.sortBy = .title
                                }
                                modelData.fetchData()
                            }
                        }
                    }
                    .padding(5)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: 40,
                           alignment: .center)
                    
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Sorting order")
                                .font(.system(size: 10, weight: .light, design: .default))
                                .padding(0)
                            Picker("Sort", selection: $sortingOrder) {
                                ForEach(sortingOptions, id:\.self) {
                                    Text($0)
                                }
                            }
                            .padding(0)
                            .onChange(of: sortingOrder) { option in
                                modelData.sortingOrder = option == "Ascending" ? .ascending : .descending
                                modelData.fetchData()
                            }
                        }
                    }
                    .padding(5)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: 40,
                           alignment: .center)

                }
            }
            .listStyle(.grouped)
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $modelData.searchString,
                        placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: modelData.searchString) { searchText in
                modelData.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: CategoriesView()) {
                        Text("Categories")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        modelData.openNewProduct.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    })
                }
            }
            .sheet(isPresented: $modelData.openNewProduct, content: {
                AddProductView()
                    .environmentObject(modelData)
            })
            .onAppear(perform: {
                modelData.fetchData()
            })
        }
    }
    
    private func deleteProducts(at indexSet: IndexSet) {
        for index in indexSet {
            let objectToDelete = modelData.products[index]
            modelData.deleteData(object: objectToDelete)
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
