//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Nursat Sakyshev on 23.01.2023.
//

import UIKit

class BlueViewController: UIViewController {
    @IBOutlet weak var testLabel: UILabel!
    var textForLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel
        //something
    }
    @IBAction func goToGreenControlller(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "greenVC")
        vc.title = "Зеленный"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
