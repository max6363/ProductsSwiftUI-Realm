//
//  DBManager.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 10/12/21.
//

import Foundation
import RealmSwift

struct DBManager {
    static func realmConfiguration() -> Realm.Configuration {
        let configuration = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldVersion in
                if oldVersion < 2 {
                    migration.enumerateObjects(ofType: "Product") { old, new in
                        let otherCategory = Category()
                        otherCategory.name = Kind.Others.rawValue
                        new?["category"] = otherCategory
                    }
                }
                if oldVersion < 3 {
                    migration.enumerateObjects(ofType: Category.className()) { oldObject, newObject in
                        newObject!["name"] = Kind.Others.rawValue
                    }
                }
                if oldVersion == 3 {
                    migration.enumerateObjects(ofType: Product.className()) { old, new in
                        new?["photos"] = [String]()
                    }
                }
            }
        )
        return configuration
    }
}
