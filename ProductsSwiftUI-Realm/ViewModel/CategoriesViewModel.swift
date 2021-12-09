//
//  CategoriesViewModel.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import Foundation
import SwiftUI
import RealmSwift

class CategoriesViewModel: ObservableObject {
    
    // Fetching categories ...
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    
    // Initialize
    init() {
        
        // print(try? Realm().configuration.fileURL?.absoluteString ?? "No db url")
        
        fetchCategories()
    }
    
    // fetch data
    func fetchCategories() {
        
        guard let dbRef = try? Realm() else { return }
        
        let results = dbRef
            .objects(Category.self)
            .distinct(by: ["name"])
        
        self.categories = results.compactMap({ (category) -> Category? in
            return category
        })
    }
    
    // fetch Products for category
    func fetchProducts(for category: Category) {
        
        guard let dbRef = try? Realm() else { return }
        
        let predicate = NSPredicate(format: "category.name == %@", category.name)
        
        let results = dbRef.objects(Product.self).filter(predicate)
        
        self.products = results.compactMap({ (product) -> Product? in
            return product
        })
    }
}
