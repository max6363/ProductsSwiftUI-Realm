//
//  Category.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import Foundation
import RealmSwift

enum Kind: String, CaseIterable, Equatable {
    
    case ConsumerElectronics
    case Stationaries
    case Food
    case MobilePhones
    case Tablets
    case FashionAccessories
    case ToysAndGames
    case Computers
    case Others

}

class Category: Object, Identifiable {

    @objc dynamic var name: String = Kind.Others.rawValue

}
