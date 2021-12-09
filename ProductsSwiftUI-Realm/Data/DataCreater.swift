//
//  DataCreater.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 08/12/21.
//

import Foundation
import RealmSwift

class DataCreater {
    
    static var dbRef = try? Realm()
    
    static func deleteAllProducts() {
        try? dbRef?.write {
            if let results = dbRef?.objects(Product.self) {
                dbRef?.delete(results)
            }
        }
    }
    
    static func insertDummyData() {
        // clear all
        deleteAllProducts()
        
        // categories
        let food = Category()
        food.name = Kind.Food.rawValue
        
        let stationaries = Category()
        stationaries.name = Kind.Stationaries.rawValue
        
        let mobilePhones = Category()
        mobilePhones.name = Kind.MobilePhones.rawValue
        
        let others = Category()
        others.name = Kind.Others.rawValue
        
        // add products
        
        let newApple = Product()
        newApple.title = "Apples"
        newApple.itemDescription = "Fresh apples"
        newApple.price = 2.99
        newApple.id = UUID()
        newApple.dateAdded = DateHelper.date(year: 2021, month: 12, day: 1)
        newApple.category = food
        
        let newPen = Product()
        newPen.title = "Pen"
        newPen.itemDescription = "Awesome product description"
        newPen.price = 0.25
        newPen.id = UUID()
        newPen.dateAdded = DateHelper.date(year: 2021, month: 6, day: 1)
        newPen.category = stationaries
        
        let newPhone = Product()
        newPhone.title = "iPhone 13 Pro"
        newPhone.itemDescription = "Awesome product description"
        newPhone.price = 1299
        newPhone.id = UUID()
        newPhone.dateAdded = DateHelper.date(year: 2021, month: 9, day: 12)
        newPhone.category = mobilePhones
        
        let newAppleJuice = Product()
        newAppleJuice.title = "Apple Juice (All fresh)"
        newAppleJuice.itemDescription = "Quality apple juice for you"
        newAppleJuice.price = 7.75
        newAppleJuice.id = UUID()
        newAppleJuice.dateAdded = Date()
        newAppleJuice.category = food
        
        let newBottle = Product()
        newBottle.title = "Water Bottle"
        newBottle.itemDescription = "Long lasting water bottle"
        newBottle.price = 2.5
        newBottle.id = UUID()
        newBottle.dateAdded = DateHelper.date(year: 2021, month: 12, day: 6)
        newBottle.category = others
        
        try? dbRef?.write {
            
            dbRef?.add(newApple)
            dbRef?.add(newPen)
            dbRef?.add(newPhone)
            dbRef?.add(newBottle)
            dbRef?.add(newAppleJuice)
            
            print("Data inserted")
        }
    }
}

class DateHelper {
    
    static func date(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
    }
}
