//
//  CategoriesView.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import SwiftUI

struct CategoriesView: View {
    
    @StateObject var modelData = CategoriesViewModel()
    
    var body: some View {
        List {
            ForEach(modelData.categories) { category in
                NavigationLink(destination: ProductsList(category: category)) {
                    HStack {
                        Text(category.name)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
