//
//  BtnSendTableViewCell.swift
//  UpaxAppExamen
//
//  Created by MaurZac on 19/12/21.
//

import UIKit

class BtnSendTableViewCell: UITableViewCell {
    
    
    let infoname = FirtsTableViewCell()
    
    var namevalue : String?
    static let identifier =  "BtnSendTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BtnSendTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnSendAction(_ sender: UIButton) {
        namevalue = "\(String(describing: infoname.userName))"
        print(namevalue)
        
    }
    
}
