//
//  CalendarViewController.swift
//  bms
//
//  Created by Artem Tischenko on 12.08.2020.
//  Copyright © 2020 Artem Tischenko. All rights reserved.
//

import KDCalendar
import UIKit

class CalendarViewController: BaseViewController {


	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var calendarView: CalendarView!


	private lazy var viewModel: CalendarViewModel = {
		getViewModel()
	}()
	private lazy var tableDataSource: DefaultTableViewDataSource = {
		DefaultTableViewDataSource(items: self.viewModel.events)
	}()
	private lazy var tableDelegate: DefaultTableViewDelegate = {
		DefaultTableViewDelegate(didSelectRow: self.viewModel.didSelectItem)
	}()

	override func viewDidLoad() {
		setupToolbar()
		setupCalendarView()
		setupTableView()
		super.viewDidLoad()
	}

	func setupToolbar() {
		title = "Calendar"
		let button = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addTapped));
		self.navigationItem.rightBarButtonItems = [button]
	}

	func setupCalendarView() {
		let today = Date()
		calendarView.direction = .horizontal
		calendarView.delegate = self
		calendarView.dataSource = self
		calendarView.multipleSelectionEnable = false
		calendarView.setDisplayDate(today, animated: false)

	}

	override func bind() {
		super.bind()

		viewModel.onSetEvents = {
			[weak self] in
			self?.calendarView.events = []
			self?.viewModel.allEvents.forEach({
				self?.calendarView.events.append(CalendarEvent(title: "", startDate: $0, endDate: $0))
			})
		}
		viewModel.onSetEventsByDate = {
			[weak self] in
			self?.tableDelegate.items = self?.viewModel.events as! [Any]
			self?.tableView.reloadData()
		}
	}

	@objc func addTapped(sender: Any) {
		viewModel.addNewItem(dates: calendarView.selectedDates)
	}

	private func setupTableView() {
		let eventNib = UINib.init(nibName: "EventViewCell", bundle: nil)
		tableView.separatorStyle = .none
		tableView.register(eventNib, forCellReuseIdentifier: "DefaultCell")
		tableView.delegate = tableDelegate
		tableView.dataSource = self
	}

}

extension CalendarViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.events.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
		let initializedCell = cell as? InitializedViewCell
		let item = viewModel.events[indexPath.row]
		initializedCell?.initialize(item: item )
		return cell
	}

}

extension CalendarViewController: CalendarViewDataSource, CalendarViewDelegate {
	func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {

	}

	func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
		viewModel.didSelectDate(date: date)
	}

	func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
		true
	}

	func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
		print("didSelectDate")
	}

	func calendar(_ calendar: CalendarView, didLongPressDate date: Date, withEvents events: [CalendarEvent]?) {

	}

	func startDate() -> Date {
		var dateComponents = DateComponents()
		dateComponents.year = -1
		let today = Date()
		let preYear = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
		return preYear!
	}

	func endDate() -> Date {
		var dateComponents = DateComponents()
		dateComponents.year = +1
		let today = Date()
		let nextYear = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
		return nextYear!
	}

	func headerString(_ date: Date) -> String? {
		nil
	}


}
