//
//  SecondTableViewCell.swift
//  UpaxAppExamen
//
//  Created by MaurZac on 19/12/21.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    static let identifier =  "SecondTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SecondTableViewCell", bundle: nil)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func callPopuP(_ sender: UIButton) {
       let vc  = SelfieViewController()
        self.window?.rootViewController!.present(vc, animated: true, completion: nil)

    }
    
}
