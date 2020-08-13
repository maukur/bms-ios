//
//  DefaultTableViewDelegate.swift
//  OrderKing
//
//  Created by Artem Tischenko on 15.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class DefaultTableViewDelegate: NSObject, UITableViewDelegate {
    
    var items: [Any] = []
    let didSelectRow: (Any) -> Void
    
    init(didSelectRow: @escaping (Any)-> Void) {
        self.didSelectRow = didSelectRow
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(items[indexPath.row])
    }
}
