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

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EventController.shared.fetchEvents()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = EventController.shared.events[indexPath.row]
        cell.updateCellWith(event: event)
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.events[indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? EventDetailViewController else { return }
            let event = EventController.shared.events[indexPath.row]
            destinationVC.event = event
        }
    }
}

extension EventListTableViewController: EventTableViewCellDelegate {
    func attendingButtonTapped(_ sender: EventTableViewCell) {
        guard let indextPath = tableView.indexPath(for: sender) else { return }
        let eventToToggle = EventController.shared.events[indextPath.row]
        EventController.shared.toggleAttendingStatus(event: eventToToggle)
        sender.updateCellWith(event: eventToToggle)
    }
}
