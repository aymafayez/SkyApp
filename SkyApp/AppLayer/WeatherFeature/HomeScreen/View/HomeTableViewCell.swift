//
//  HomeTableViewCell.swift
//  SkyApp
//
//  Created by Guest2 on 12/26/19.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var citiyNameLabel: UILabel!
    @IBOutlet weak var weatherDecriptionLabel: UILabel!
    @IBOutlet weak var weatherDegreeLabel: UILabel!
    weak var delegate: HomeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func weatherButtonDidPressed(_ sender: Any) {
        delegate?.removeProduct(at: indexPath!)
    }
}


extension UIResponder {
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
