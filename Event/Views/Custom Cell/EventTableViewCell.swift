//
//  EventTableViewCell.swift
//  Event
//
//  Created by Lee McCormick on 1/22/21.
//

import UIKit

// MARK: - Protocol
protocol EventTableViewCellDelegate: AnyObject {
    func attendingButtonTapped(_ sender: EventTableViewCell)
}

class EventTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var eventTitleLabel : UILabel!
    @IBOutlet weak var eventAttendingButton : UIButton!
    
    // MARK: - Properties
    weak var delegate: EventTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func attendingStatusButtonTapped (_ sender: Any) {
        delegate?.attendingButtonTapped(self)
    }

    // MARK: - Helper Fuctions
    func updateCellWith(event: Event) {
        eventTitleLabel.text = event.title
        let buttonImage = event.attendingStatus ? UIImage(systemName: "clock.fill")  : UIImage(systemName: "clock")
        eventAttendingButton.setImage(buttonImage, for: .normal)
    }
}
