//
//  DefaultTableViewDataSource.swift
//  OrderKing
//
//  Created by Artem Tischenko on 15.05.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class DefaultTableViewWithSectionsDataSource:NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var items: Dictionary<AnyHashable, [Any]>
    var headerHeight : Int
    
    init(items: Dictionary<AnyHashable, [Any]>, headerHeight: Int, didSelectRow: @escaping (Any)-> Void) {
        self.items = items
        self.headerHeight = headerHeight
        self.didSelectRow = didSelectRow
        
    }
    
    func getKeyBySection(section:Int) -> AnyHashable {
        Array(items.keys)[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = items[getKeyBySection(section:section)]?.count ?? 0
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count =  items.count
        return count
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell")!
        let initializedCell = cell as? InitializedViewCell
        initializedCell?.initialize(item: getKeyBySection(section: section))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        let initializedCell = cell as? InitializedViewCell
        initializedCell?.initialize(item: items[getKeyBySection(section: indexPath.section)]![indexPath.row])
        return cell
    }
    
     
    
    let didSelectRow: (Any) -> Void
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(items[getKeyBySection(section: indexPath.section)]![indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

