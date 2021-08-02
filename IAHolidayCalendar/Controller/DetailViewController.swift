//
//  DetailViewController.swift
//  IAHolidayCalendar
//
//  Created by Juan Reyes on 8/2/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name

    }

}
