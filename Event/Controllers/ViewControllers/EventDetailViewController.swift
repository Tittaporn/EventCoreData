//
//  EventDetailViewController.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var eventTitleTextField : UITextField!
    @IBOutlet weak var eventDatePicker : UIDatePicker!
    @IBOutlet weak var createOrUpdateLabel: UILabel!
    
    // MARK: - Properties
    var event: Event?
    var date: Date? = Date()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        NotificationCenter.default.addObserver(self, selector: #selector(notificationObserved), name: NSNotification.Name("eventReminderNotification"), object: nil)
    }
    
    // MARK: - Actions
    @IBAction func saveEventButtonTapped(_ sender: Any) {
        guard let eventTitle = eventTitleTextField.text, !eventTitle.isEmpty else { return }
        if let event = event {
            EventController.shared.updateEvent(event: event, title: eventTitle, date: eventDatePicker.date)
        } else {
            EventController.shared.creatEvent(title: eventTitle, date: eventDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func evenDateValueChanged(_ sender: Any) {
        self.date = eventDatePicker.date
        
    }
    
    // MARK: - Helper Fuctions
    func updateViews() {
        if let event = event {
            createOrUpdateLabel.text = "Update Event"
            eventTitleTextField.text = event.title
            eventDatePicker.date = event.date ?? Date()
        } else {
            createOrUpdateLabel.text = "Create New Event"
        }
    }
    
    // MARK: - Notification Function
    @objc func notificationObserved() {
        let bgColor = view.backgroundColor
        view.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.backgroundColor = bgColor
        }
    }
}
