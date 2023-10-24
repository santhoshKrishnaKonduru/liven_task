//
//  Group.swift
//  Liven_Task
//
//  Created by Santhosh Konduru on 23/10/23.
//

import Foundation

struct Group {
    var name: GroupMember
    var items: [Item]
    var discount: Double
    var isCreditCardPayment: Bool
    var totalMembers: Int
}

enum GroupMember: String {
    case Group1 = "Group 1", Group2 = "Group 2", Group3 = "Group 3"
}
