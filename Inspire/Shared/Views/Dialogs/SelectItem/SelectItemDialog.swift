//
//  SelectItemDialog.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class SelectItemDialog: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tableView: MyTableView!
    var items : [Item]!
    var chooseItemProtocol : ChooseItemProtocol!
    var requestCode : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.backAction)))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        self.tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
    }
    
    @objc func backAction() {
        self.dismiss(animated: true)
    }
}

protocol ChooseItemProtocol : AnyObject {
    func chooseItem(item : Item, requestCode : Int)
}

extension SelectItemDialog: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ItemCell = tableView.dequeueReusableCell(withIdentifier: ItemCell.stringRepresentation) as! ItemCell
        let lastIndex = tableView.numberOfRows(inSection: 0) - 1
        cell.loadCell(item: items[indexPath.item], lastIndex: indexPath.item == lastIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.items.count
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.chooseItemProtocol.chooseItem(item: self.items[indexPath.item], requestCode: self.requestCode)
        }
    }
}
