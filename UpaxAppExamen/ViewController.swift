//
//  ViewController.swift
//  UpaxAppExamen
//
//  Created by MaurZac on 17/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet var table : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(FirtsTableViewCell.nib(), forCellReuseIdentifier: FirtsTableViewCell.identifier)
        table.register(SecondTableViewCell.nib(), forCellReuseIdentifier: SecondTableViewCell.identifier)
        table.register(BtnSendTableViewCell.nib(), forCellReuseIdentifier: BtnSendTableViewCell.identifier)

        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row  == 1 {
            let customCell = tableView.dequeueReusableCell(withIdentifier: FirtsTableViewCell.identifier, for: indexPath) as! FirtsTableViewCell
            return customCell
        }
        if indexPath.row == 2 {
            let secondCell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as! SecondTableViewCell
            return secondCell
        }
        if indexPath.row == 3 {
            let btnCell = tableView.dequeueReusableCell(withIdentifier: BtnSendTableViewCell.identifier, for: indexPath) as! BtnSendTableViewCell
            return btnCell
        }
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "UPAX"
        cell.textLabel?.textAlignment = .center
        cell.accessoryView = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row  == 0 {
            return 30
        }
        if indexPath.row  == 2 {
            return 70
        }
        if indexPath.row  == 3 {
            return 50
        }
        return 100
    }
   


}

