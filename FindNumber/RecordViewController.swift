//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Nursat Sakyshev on 17.03.2023.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        print(record)
//        if record != 0 {
//            recordLabel.text = "Your record - \(record)"
//        }
//        else {
//            recordLabel.text = "Haven't set a record"
//        }
        recordLabel.text = "\(record)"
    }
    
  

    @IBAction func closeVC(_ sender: Any) {
        UserDefaults.standard.synchronize()
        dismiss(animated: true)
    }
}
