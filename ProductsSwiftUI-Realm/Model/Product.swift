//
//  Product.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 08/12/21.
//

import Foundation
import RealmSwift

class Product: Object, Identifiable {
    
    @objc dynamic var id = UUID()
    @objc dynamic var title = ""
    @objc dynamic var itemDescription = ""
    @objc dynamic var price = 0.0
    @objc dynamic var dateAdded: Date = Date()
    
}
