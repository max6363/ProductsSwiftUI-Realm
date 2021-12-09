//
//  Category.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 09/12/21.
//

import Foundation
import RealmSwift
/*
protocol EnumerableEnum {
    init?(rawValue: Int)
    static func firstRawValue() -> Int
}

extension EnumerableEnum {
    static func enumerate() -> AnyIterator<Self> {
        var nextIndex = firstRawValue()

        let iterator: AnyIterator<Self> = AnyIterator {
            defer { nextIndex = nextIndex + 1 }
            return Self(rawValue: nextIndex)
        }

        return iterator
    }

    static func firstRawValue() -> Int {
        return 0
    }
}

@objc enum Kind: Int, RealmEnum, CustomStringConvertible, EnumerableEnum {
    
    case ConsumerElectronics
    case Stationaries
    case Food
    case MobilePhones
    case Tablets
    case FashionAccessories
    case ToysAndGames
    case Computers
    case Others
    
    var kind: Kind {
        switch self.description {
        case "Consumer Electronics":
            return .ConsumerElectronics
        case "Stationaries":
            return .Stationaries
        case "Food":
            return .Food
        case "Mobile Phones":
            return .MobilePhones
        case "Tablets":
            return .Tablets
        case "Fashion Accessories":
            return .FashionAccessories
        case "ToysAndGames":
            return .ToysAndGames
        case "Computers":
            return .Computers
        case "Others":
            return .Others
        default:
            return .Others
        }
    }
    
    var description: String {
        switch self {
        case .ConsumerElectronics:
            return "Consumer Electronics"
        case .Stationaries:
            return "Stationaries"
        case .Food:
            return "Food"
        case .MobilePhones:
            return "Mobile Phones"
        case .Tablets:
            return "Tablets"
        case .FashionAccessories:
            return "Fashion Accessories"
        case .ToysAndGames:
            return "Toys & Games"
        case .Computers:
            return "Computers"
        case .Others:
            return "Others"
        }
    }
}

class Category: Object {

    @objc dynamic var name: Kind = .Others

}
*/

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

class Category: Object {

    @objc dynamic var name: String = Kind.Others.rawValue

}
