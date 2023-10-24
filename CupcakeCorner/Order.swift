//
//  Order.swift
//  CupcakeCorner
//
//  Created by Zach Mommaerts on 10/24/23.
//

import Foundation

struct Order {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cupcake
        var cost = Double(quantity) * 2
        
        // Complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1 per cupcake with extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50 per cupcake for sprinkles
        if addSprinkles {
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
}
