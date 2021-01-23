//
//  EventTableViewCell.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import UIKit

// MARK: - Protocol
protocol EventTableViewCellDelegate: AnyObject {
    func attendingButtonTapped(event: Event, attendingStatus: Bool)
}

class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var eventTitleLabel : UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventAttendingButton : UIButton!
    
    // MARK: - Properties
    var event: Event? {
        didSet {
            updateCell()
        }
    }
    var attendingStatus: Bool = false
    weak var delegate: EventTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func attendingStatusButtonTapped (_ sender: Any) {
        guard let event = event else { return }
        attendingStatus.toggle()
        print("The event tapping : \(event.attendingStatus)")
        delegate?.attendingButtonTapped(event: event, attendingStatus: attendingStatus)
    }
    
    // MARK: - Helper Fuctions
    func updateCell() {
        guard let event = event else { return }
        
        eventTitleLabel.text = event.title
        eventDateLabel.text = event.date?.dateToString() ?? "No Date Attending"
        attendingStatus = event.attendingStatus
        let buttonImage = attendingStatus ? UIImage(systemName: "clock.fill")  : UIImage(systemName: "clock")
        eventAttendingButton.setImage(buttonImage, for: .normal)
    }
}
