//
//  DBViewModel.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 08/12/21.
//

import Foundation
import RealmSwift
import SwiftUI

enum SortBy {
    case title
    case dateAdded
}

enum SortingOrder {
    case ascending
    case descending
}

class DBViewModel: ObservableObject {
    
    // Fetched Data ...
    @Published var products: [Product] = []
    
    // Searching ...
    @Published var searchString: String = ""
    
    @Published var sortBy: SortBy = .dateAdded
    
    @Published var sortingOrder: SortingOrder = .ascending
    
    // Initialize ...
    init() {
        DataCreater.insertDummyData()
        fetchData()
    }
    
    // Fetching Data...
    func fetchData() {
        
        guard let dbRef = try? Realm() else { return }
        
        var results = dbRef.objects(Product.self)
        
        if sortBy == .title {
            results = results.sorted(byKeyPath: "title",
                                     ascending: sortingOrder == .ascending)
            
        } else if sortBy == .dateAdded {
            results = results.sorted(byKeyPath: "dateAdded",
                                     ascending: sortingOrder == .ascending)
        }
        
        if searchString.count > 0 {
            let predicate = NSPredicate(format: "title BEGINSWITH [c]%@", searchString)
            results = results.filter(predicate)
        }
        
        self.products = results.compactMap({ (product) -> Product? in
            return product
        })
    }
}
