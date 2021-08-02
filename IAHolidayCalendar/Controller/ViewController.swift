//
//  ViewController.swift
//  IAHolidayCalendar
//
//  Created by Juan Reyes on 8/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var calendar: UICollectionView!
    
    //MARK: - Calendar CollectionView Population Components
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCellUI()
    }
    
    func setCellUI() {
        let width = (calendar.frame.size.width - 2) / 8
        let height = (calendar.frame.size.height - 2) / 8
        
        let layout = calendar.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
    }
    
    @IBAction func previousMonth(_ sender: UIButton) {
    }
    
}

