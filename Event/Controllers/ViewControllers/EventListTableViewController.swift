//
//  EventListTableViewController.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import UIKit

class EventListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(notificationObserved), name: NSNotification.Name("eventReminderNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EventController.shared.fetchEvents()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return EventController.shared.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.sections[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = EventController.shared.sections[indexPath.section][indexPath.row]
        cell.event = event
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.sections[indexPath.section][indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50.0)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if EventController.shared.attendingEvents.count == 0 {
                return ""
            }
            return "ATTENDING EVENTS"
        } else if section == 1 {
            if EventController.shared.notAttendingEvents.count == 0 {
                return ""
            }
            return "NOT ATTENDING EVENTS"
        } else {
            return nil
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.systemOrange
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 20)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EventDetailViewController else { return }
            let event = EventController.shared.sections[indexPath.section][indexPath.row]
            destinationVC.event = event
        }
    }
    
    // MARK: - Notification Function
    @objc func notificationObserved() {
        let bgColor = tableView.backgroundColor
        tableView.backgroundColor = .red
        view.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.tableView.backgroundColor = bgColor
            self.view.backgroundColor = bgColor
        }
    }
}

extension EventListTableViewController: EventTableViewCellDelegate {
    func attendingButtonTapped(event: Event, attendingStatus: Bool) {
        EventController.shared.toggleAttendingStatus(event: event)
        tableView.reloadData()
    }
}
