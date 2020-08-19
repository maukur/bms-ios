//
//  ExpensesViewController.swift
//  bms
//
//  Created by Artem Tischenko on 14.07.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import UIKit

class ExpensesViewController: BaseViewController {
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var tableDataSource: DefaultTableViewWithSectionsDataSource = {
        DefaultTableViewWithSectionsDataSource(items:[:], headerHeight: 42, didSelectRow: self.viewModel.editItem )
    }()
    
    private lazy var viewModel: ExpensesViewModel = { getViewModel() }()
    
    override func viewDidLoad() {
        title = "Expenses"
        setupTableView()
        let button = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addTapped));
        self.navigationItem.rightBarButtonItems = [button]
        super.viewDidLoad()
    }
    override func bind() {
        viewModel.onDateUpdate = {  [weak self]  date in
            guard let self = self else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            self.yearLabel.text = dateFormatter.string(from: date)
        }
        
        viewModel.onDataUpdate = { [weak self] data in
            guard let self = self else { return }
            self.tableDataSource.items = data
            self.tableView.reloadData()
        }
        
    }
    private func setupTableView(){
        let expensesNib = UINib.init(nibName: "ExpensesViewCell", bundle: nil)
        let monthNib = UINib.init(nibName: "SectionHeaderCell", bundle: nil)
        tableView.separatorStyle = .none
        tableView.register(monthNib, forCellReuseIdentifier: "SectionHeaderCell")
        tableView.register(expensesNib, forCellReuseIdentifier: "DefaultCell")
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDataSource
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        viewModel.goToThePreviousYear()
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        viewModel.goToTheNextYear()
    }
    
    @objc func addTapped(sender: Any)
    {
        viewModel.addNewItem()
    }
}


