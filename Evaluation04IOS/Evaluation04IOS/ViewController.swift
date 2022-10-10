//
//  ViewController.swift
//  Evaluation04IOS
//
//  Created by Student06 on 10/10/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var sectionTableView: UITableView!{
        didSet{
            sectionTableView.dataSource = self
        }
    }
    
    let managedObjectContext = AppDelegate.shared.persistentContainer.viewContext
    var expenses = [Expense]()
    var sections = [ExpenseSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSectionsFromData()
        loadExpensesFromData()
        
        if(sections.isEmpty){
            for sectionType in SectionHeader.allCases{
                addNewSection(name: sectionType.rawValue)
            }
        }
        
        if(expenses.isEmpty){
            addNewExpense(name: "Cinéma", value: 12.00)
            
            addNewExpense(name: "Boursin", value: 5.0)
            addNewExpense(name: "Pain", value: 2.0)
            addNewExpense(name: "Vin", value: 12.0)
        }
        
        loadSectionsFromData()
        loadExpensesFromData()
        
    }

    @IBAction func addButton(_ sender: Any) {
        
        if let detailViewController =
        storyboard?.instantiateViewController(identifier:
                                                "detailNavigation") as? DetailNavigation{
            detailViewController.modalPresentationStyle = .automatic
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        
    }
    
    func addNewExpense(name : String, value : Float, date : Date = Date.init()){
        
        let newExpense = Expense(context: managedObjectContext)
        newExpense.name = name
        newExpense.value = value
        newExpense.date = date
        
        saveData()
        loadExpensesFromData()
        
    }
    
    func addNewSection(name : String){
        
        let newSection = ExpenseSection(context: managedObjectContext)
        newSection.name = name
        
        saveData()
        loadSectionsFromData()
        
    }
    
    func loadExpensesFromData(){
        
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        
        let orderByalphaOrder = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [orderByalphaOrder]
        
        do {
            expenses = try managedObjectContext.fetch(request)
        } catch{
            print("Can't access Core Data")
        }
        
       sectionTableView.reloadData()
    }
    
    func loadSectionsFromData(){
        
        let request = NSFetchRequest<ExpenseSection>(entityName: "ExpenseSection")
        
        let orderByalphaOrder = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [orderByalphaOrder]
        
        do {
            sections = try managedObjectContext.fetch(request)
        } catch{
            print("Can't access Core Data")
        }
        
       sectionTableView.reloadData()
    }
    
    func saveData(){
        do{
            try managedObjectContext.save()
        } catch{
            fatalError("Couldn't save data")
        }
    }
    
}

extension ViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        SectionHeader.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return SectionHeader.allCases[section].rawValue
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(section){
        case 0: return sections.count
        case 1 : return expenses.count
        default : return 0
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        if(indexPath.section == 0){
            cell.textLabel?.text = "\(sections[indexPath.row].name ?? "???")                            0.00€"
        }else{
            cell.textLabel?.text = "\(expenses[indexPath.row].name ?? "???")                            \(expenses[indexPath.row].value) €"
        }
        return cell
    }
    
}

enum SectionHeader : String, CaseIterable{
    case tax = "Impôt"; case hobby = "Loisirs"; case house = "Maison"; case meal = "Nourriture"; case car = "Voiture"
}

