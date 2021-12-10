//
//  ProductsList.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import SwiftUI

struct ProductsList: View {
    
    var category: Category
    
    @StateObject var categoryModelData = CategoriesViewModel()
    
    var body: some View {
        List {
            ForEach(categoryModelData.products) { product in
                ProductItemRow(product: product)
            }
        }
        .navigationTitle(Text(category.name))
        .onAppear(perform: {
            categoryModelData.fetchProducts(for: category)
        })
    }
}

struct ProductsList_Previews: PreviewProvider {
    static var previews: some View {
        ProductsList(category: Category())
    }
}
