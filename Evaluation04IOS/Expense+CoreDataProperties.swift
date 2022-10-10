//
//  Expense+CoreDataProperties.swift
//  Evaluation04IOS
//
//  Created by Student06 on 10/10/2022.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var value: Float
    @NSManaged public var relationship: ExpenseSection?

}

extension Expense : Identifiable {

}
