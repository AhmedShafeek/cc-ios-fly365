//
//  FlightResultCell.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class FlightResultCell: UITableViewCell {

    @IBOutlet weak var boundsTV: MyTableView!
    var legs : [Leg]!
    var totalPrice : String!
    var currency : String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.boundsTV.delegate = self
        self.boundsTV.dataSource = self
        // Initialization code
    }
    
    func loadCell(itinerary : Itinerary, currency : String) {
        self.currency = currency
        self.totalPrice = String(itinerary.pricing.total)
        self.legs = itinerary.legsOBJ
        self.boundsTV.estimatedRowHeight = UITableView.automaticDimension
        self.boundsTV.rowHeight = UITableView.automaticDimension
        self.boundsTV.reloadData()
//        self.boundsTV.layoutIfNeeded()
//        self.boundsTV.heightAnchor.constraint(equalToConstant: self.boundsTV.contentSize.height).isActive = true
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.boundsTV.reloadData()
        self.boundsTV.layoutIfNeeded()
        self.boundsTV.heightAnchor.constraint(equalToConstant: self.boundsTV.contentSize.height).isActive = true
        // if the table view is the last UI element, you might need to adjust the height
        let size = CGSize(width: targetSize.width,
                          height: self.boundsTV.frame.origin.y + self.boundsTV.contentSize.height)
        return size
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension FlightResultCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BoundResultCell = tableView.dequeueReusableCell(withIdentifier: BoundResultCell.stringRepresentation) as! BoundResultCell
        let lastIndex = tableView.numberOfRows(inSection: 0) - 1
        cell.loadCell(leg : self.legs[indexPath.item], totalPrice: totalPrice, currency : currency, lastIndex : indexPath.item == lastIndex)
        cell.layoutSubviews()
        cell.setNeedsLayout()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.legs.count
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
