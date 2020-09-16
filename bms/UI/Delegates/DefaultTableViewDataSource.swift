//
//  DefaultTableViewDataSource.swift
//  OrderKing
//
//  Created by Artem Tischenko on 15.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class DefaultTableViewDataSource: NSObject, UITableViewDataSource {
    var items: [Any]
    init(items: [Any]) {
        self.items = items
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        let initializedCell = cell as? InitializedViewCell
        initializedCell?.initialize(item: items[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(items[indexPath.row])
    }
}
