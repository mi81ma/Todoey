//
//  Data.swift
//  Todoey
//
//  Created by masato on 14/12/2018.
//  Copyright © 2018 masato. All rights reserved.
//

import Foundation
import RealmSwift

class  Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
