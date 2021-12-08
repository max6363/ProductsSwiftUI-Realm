//
//  ProductListView.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 08/12/21.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var sortingOption = "Date Added"
    var options = ["Date Added", "Title"]
    
    @State private var sortingOrder = "Ascending"
    var sortingOptions = ["Ascending", "Descending"]
    
    @StateObject var modelData = DBViewModel()
    
    var body: some View {
        NavigationView {
                        
            VStack {
                
                SegmentedView(selectedOption: $sortingOption,
                              text: "Sort by",
                              options: options)
                    .onChange(of: sortingOption) { option in
                        modelData.sortBy = option == "Date Added" ? .dateAdded : .title
                        modelData.fetchData()
                    }
                
                SegmentedView(selectedOption: $sortingOrder,
                              text: "Sorting order",
                              options: sortingOptions)
                    .onChange(of: sortingOrder) { option in
                        modelData.sortingOrder = option == "Ascending" ? .ascending : .descending
                        modelData.fetchData()
                    }
                
                List {
                    ForEach(modelData.products) { product in
                        ProductItemRow(product: product)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Products")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $modelData.searchString,
                        placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: modelData.searchString) { searchText in
                modelData.fetchData()
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}

struct ProductItemRow: View {
    
    var product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.system(size: 22, weight: .medium, design: .default))
                Text(product.itemDescription)
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(product.dateAdded.formatted())
                    .font(.caption2)
            }
            Spacer()
            Text(String(format: "$%.2f", product.price))
                .font(.system(size: 19, weight: .regular, design: .default))
        }
    }
}

struct SegmentedView: View {
    
    @Binding var selectedOption: String
    var text: String
    var options: [String]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(text)
                    .font(.caption)
                Picker(text, selection: $selectedOption) {
                    ForEach(options, id:\.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(5)
    }
}
