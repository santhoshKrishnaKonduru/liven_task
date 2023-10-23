//
//  ViewController.swift
//  Liven_Task
//
//  Created by Santhosh Konduru on 23/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    let group1Items = [
        Item(name: "Big Brekkie", price: 16, quantity: 2),
        Item(name: "Bruchetta", price: 8, quantity: 1),
        Item(name: "Poached Eggs", price: 12, quantity: 1),
        Item(name: "Coffee", price: 5, quantity: 1),
        Item(name: "Tea", price: 3, quantity: 1),
        Item(name: "Soda", price: 4, quantity: 1)
    ]
    
    let group2Items = [
        Item(name: "Tea", price: 3, quantity: 1),
        Item(name: "Coffee", price: 3, quantity: 3),
        Item(name: "Soda", price: 4, quantity: 1),
        Item(name: "Big Brekkie", price: 16, quantity: 3),
        Item(name: "Poached Eggs", price: 12, quantity: 1),
        Item(name: "Garden Salad", price: 10, quantity: 1)
    ]
    
    let group3Items = [
        Item(name: "Tea", price: 3, quantity: 2),
        Item(name: "Coffee", price: 3, quantity: 3),
        Item(name: "Soda", price: 4, quantity: 2),
        Item(name: "Bruchetta", price: 8, quantity: 5),
        Item(name: "Big Brekkie", price: 16, quantity: 5),
        Item(name: "Poached Eggs", price: 12, quantity: 2),
        Item(name: "Garden Salad", price: 10, quantity: 3)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let group1 = Group(name: "Group 1", items: group1Items, discount: 0.0, isCreditCardPayment: false)
        let group2Discount = 0.10 // 10% discount on credit card
        let group2 = Group(name: "Group 2", items: group2Items, discount: group2Discount, isCreditCardPayment: true)
        let group3Discount = 25.0 // $25 discount from restaurant
        let group3 = Group(name: "Group 3", items: group3Items, discount: 25.0, isCreditCardPayment: false)
        // Scripting the transactions
        print("Scripting the transactions:")
        let groups = [group1, group2, group3]
        for group in groups {
            print("\n\nProcessing \(group.name) transaction:")
            if group.name == "Group 3" {
                splitPayment(for: group)
            } else {
                displayInvoice(for: group)
            }
        }


    }
    
    func calculateBill(for group: Group) -> (Double, Double) {
        var totalBill = group.items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        if group.name == "Group 2" {
            totalBill -= totalBill * group.discount
        }
        let taxes = totalBill * 0.10
        if group.isCreditCardPayment {
            totalBill += totalBill * 0.012
        }
        return (totalBill, taxes)
    }
    
    
    func displayInvoice(for group: Group) {
        let (totalBill, taxes) = calculateBill(for: group)
        print("\n\(group.name) menu items\n")
        for item in group.items {
            print("\(item.name) $\(item.price) x \(item.quantity)")
        }
        print("\nTotal: $\(totalBill.rounded(toPlaces: 2))")
        print("Taxes: $\(taxes.rounded(toPlaces: 2))")
        print("Discount: $\((totalBill * group.discount).rounded(toPlaces: 2))")
        
        if group.isCreditCardPayment {
            print("Credit Card Surcharge: $\((totalBill * 0.012).rounded(toPlaces: 2))")
        }
        
        print("\nPayment details:")
        if group.items.count > 1 {
            print("Paid $\(totalBill.rounded(toPlaces: 2)), returned $0, remaining $0")
        } else {
            print("Paid $0, returned $0, remaining $\((totalBill + taxes).rounded(toPlaces: 2))")
        }
    }
    
    
    func splitPayment(for group: Group) {
        let initialTab = 50.0
        let discount = group.discount
        let (totalBill, taxes) = calculateBill(for: group)
        let remainingBill = totalBill - discount
        let individualPayment = remainingBill / Double(group.items.count)
        let returnedAmount = discount / Double(group.items.count)

        print("\n\(group.name) menu items\n")
        for item in group.items {
            print("\(item.name) $\(item.price) x \(item.quantity)")
        }
        print("\nTotal: $\(totalBill.rounded(toPlaces: 2))")
        print("Taxes: $\(taxes.rounded(toPlaces: 2))")
        print("Discount: $\(discount.rounded(toPlaces: 2))")
        print("Initial Tab: $\(initialTab.rounded(toPlaces: 2))")
        print("Individual Payment: $\(individualPayment.rounded(toPlaces: 2))\n")
        print("Payment details:")
        
        for member in 1...group.items.count {
            print("Group Member\(member) Paid $\(individualPayment.rounded(toPlaces: 2)), returned $\(returnedAmount.rounded(toPlaces: 2)), remaining $0")
        }
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
