//
//  ExpenseSection+CoreDataProperties.swift
//  Evaluation04IOS
//
//  Created by Student06 on 10/10/2022.
//
//

import Foundation
import CoreData


extension ExpenseSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseSection> {
        return NSFetchRequest<ExpenseSection>(entityName: "ExpenseSection")
    }

    @NSManaged public var name: String?
    @NSManaged public var relationship: Expense?

}

extension ExpenseSection : Identifiable {

}
