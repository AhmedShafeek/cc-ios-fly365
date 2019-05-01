//
//  Tab.swift
//
//  Created by Ahmed Shafeek
//  Copyright © 2019 Ahmed Shafeek. All rights reserved.
//

import Foundation
import UIKit

public struct Tab {
    
    public var id : Int = 0
    public var title : String = ""
    public var icon : UIImage = UIImage()
    public var selectedIcon : UIImage = UIImage()
    public var selected : Bool = false
    public var selectedColor : String = ""
    
    public init(id : Int, title : String, icon : UIImage, selected : Bool) {
        self.id = id
        self.title = title
        self.icon = icon
        self.selected = selected
    }
}
