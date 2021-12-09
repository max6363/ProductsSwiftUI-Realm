//
//  ProductsList.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import SwiftUI

struct ProductsList: View {
    
    var category: Category
    
    @StateObject var modelData = DBViewModel()
    
    @StateObject var categoryModelData = CategoriesViewModel()
    
    var body: some View {
        List {
            ForEach(categoryModelData.products) { product in
                ProductItemRow(product: product)
                    .onTapGesture {

                        modelData.title = product.title
                        modelData.itemDescription = product.itemDescription
                        modelData.price = "\(product.price)"
                        modelData.updateProduct = product
                        modelData.openNewProduct.toggle()
                    }
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
