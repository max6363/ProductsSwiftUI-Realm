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
    case price
}

enum SortingOrder {
    case ascending
    case descending
}

class DBViewModel: ObservableObject {
    
    // Adding Data ...
    @Published var title = ""
    @Published var itemDescription = ""
    @Published var price = "0"
    @Published var category: Kind = .Others
    
    // Fetched Data ...
    @Published var products: [Product] = []
    
    // Searching ...
    @Published var searchString: String = ""
    @Published var sortBy: SortBy = .title
    @Published var sortingOrder: SortingOrder = .ascending
    
    // Dismiss Adding Page ...
    @Published var openNewProduct = false
    
    // Update Product Object ...
    @Published var updateProduct: Product? = nil
    
    // Initialize ...
    init() {
//        DataCreater.insertDummyData()
        fetchData()
    }
    
    // Fetching Data...
    func fetchData() {
        
        guard let dbRef = try? Realm(configuration: DBManager.realmConfiguration()) else { return }
        
        var results = dbRef.objects(Product.self)
        
        if sortBy == .title {
            results = results.sorted(byKeyPath: "title",
                                     ascending: sortingOrder == .ascending)
            
        } else if sortBy == .dateAdded {
            results = results.sorted(byKeyPath: "dateAdded",
                                     ascending: sortingOrder == .ascending)
        } else if sortBy == .price {
            results = results.sorted(byKeyPath: "price",
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
    
    // Adding data ...
    func addData(object: Product) {
        
        // reference
        guard let dbRef = try? Realm(configuration: DBManager.realmConfiguration()) else { return }
        
        // writing data
        try? dbRef.write {
            
            dbRef.add(object)
            
            fetchData()
        }
    }
    
    // Updating data ...
    func updateData(object: Product) {
        
        // reference
        guard let dbRef = try? Realm(configuration: DBManager.realmConfiguration()) else { return }
        
        // updating data
        try? dbRef.write {
            object.title = title
            object.itemDescription = itemDescription
            object.price = Double(price) ?? 0.0
            object.category?.name = category.rawValue
            fetchData()
        }
    }
    
    // Delete data ...
    func deleteData(object: Product) {
        
        // reference
        guard let dbRef = try? Realm(configuration: DBManager.realmConfiguration()) else { return }
        
        // deleting data
        try? dbRef.write {
            dbRef.delete(object)
            
            fetchData()
        }
    }
    
    // Setting and Clearing Data ...
    
    func setupInitialData() {
        guard let updateData = updateProduct else {
            return
        }
        
        title = updateData.title
        itemDescription = updateData.itemDescription
        price = "\(updateData.price)"
        if let category_ = Kind(rawValue: updateData.category?.name ?? Kind.Others.rawValue) {
            category = category_
        } else {
            category = .Others
        }
    }
    
    func deInitData() {
        updateProduct = nil
        title = ""
        itemDescription = ""
        price = ""
        category = .Others
    }
}


