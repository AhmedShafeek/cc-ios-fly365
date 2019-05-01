//
//  MainViewController.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(hexString: AppConstants.Colors.primaryColor)
        navigationController?.navigationBar.shouldRemoveShadow(true)
        self.embedView(identifier: FlightsSearchViewController.stringRepresentation, storyboardName: "FlightsSearch", title : "book_your_flight".localized())
    }
    
    func embedView(identifier: String, storyboardName : String, title : String) {
        self.title = title
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller: UIViewController = storyboard.instantiateViewController(withIdentifier: identifier) as UIViewController
        addChild(controller)
        controller.view.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
        self.mainView.addSubview(controller.view)
    }
}
