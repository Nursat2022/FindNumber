//
//  SelectTimeViewController.swift
//  FindNumber
//
//  Created by Nursat Sakyshev on 24.01.2023.
//

import UIKit

class SelectTimeViewController: UIViewController {
    
    var data: [Int] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView? .delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
    
    }
}

extension SelectTimeViewController:
    UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = String(data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        UserDefaults.standard.setValue(data[indexPath.row], forKey: "timeForGame")
//        UserDefaults.standard.integer(forKey: "timeForGame")
          
        
        Settings.shared.currentSettings.timeForGame = data[indexPath.row]
//        print(data[indexPath.row])
        
        navigationController?.popViewController(animated: true)
    }
}
