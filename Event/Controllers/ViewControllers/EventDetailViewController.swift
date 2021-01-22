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
    
    // MARK: - Properties
    var event: Event?
    var date: Date? = Date()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveEventButtonTapped(_ sender: Any) {
        guard let eventTitle = eventTitleTextField.text, !eventTitle.isEmpty else { return }
              let evenDate = eventDatePicker.date
        if let event = event {
            EventController.shared.updateEvent(event: event, title: eventTitle, date: evenDate)
        } else {
            EventController.shared.creatEvent(title: eventTitle, date: evenDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eventDatePickerChanged(_ sender: Any) {
        date = eventDatePicker.date
    }
    
    // MARK: - Helper Fuctions
    func updateViews() {
        guard let event = event else { return }
        eventTitleTextField.text = event.title
        eventDatePicker.date = event.date ?? Date()
    }
}
