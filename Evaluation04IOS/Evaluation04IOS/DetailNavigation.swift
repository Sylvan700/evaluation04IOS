//
//  DetailNavigation.swift
//  Evaluation04IOS
//
//  Created by Student06 on 10/10/2022.
//

import UIKit

class DetailNavigation: UIViewController {
    @IBOutlet weak var produitText: UITextField!
    @IBOutlet weak var quantText: UITextField!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var sectionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title.self = "Nouvelle dépense"
    }


}
