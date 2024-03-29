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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let expensesNib = UINib.init(nibName: "ExpensesViewCell", bundle: nil)
            let monthNib = UINib.init(nibName: "SectionHeaderCell", bundle: nil)
            tableView.separatorStyle = .none
            tableView.register(monthNib, forCellReuseIdentifier: "SectionHeaderCell")
            tableView.register(expensesNib, forCellReuseIdentifier: "DefaultCell")
            tableView.dataSource = tableDataSource
            tableView.delegate = tableDataSource
        }
    }
    @IBOutlet weak var previousButton: UIButton! {
        didSet {
            let conf = UIImage.SymbolConfiguration(pointSize: 17, weight: UIImage.SymbolWeight.bold)
            previousButton.setImage( UIImage(named: "chevron.left", in: .none, with: conf), for: .normal)
            previousButton.tintColor = .white
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            let conf = UIImage.SymbolConfiguration(pointSize: 17, weight: UIImage.SymbolWeight.bold)
            nextButton.setImage( UIImage(named: "chevron.right", in: .none, with: conf), for: .normal)
            nextButton.tintColor = .white
        }
    }
    private lazy var tableDataSource: DefaultTableViewWithSectionsDataSource = {
        DefaultTableViewWithSectionsDataSource(items: [:], headerHeight: 42, didSelectRow: self.viewModel.editItem)
    }()
    private lazy var viewModel: ExpensesViewModel = { getViewModel() }()
    override func viewDidLoad() {
        title = "EXPENSES"
        let button = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
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
    @IBAction func previousButtonAction(_ sender: Any) {
        viewModel.goToThePreviousYear()
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        viewModel.goToTheNextYear()
    }
    @objc func addTapped(sender: Any) {
        viewModel.addNewItem()
    }
}
