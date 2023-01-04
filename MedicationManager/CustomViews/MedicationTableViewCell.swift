//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by Mackenzie Wacker on 12/8/22.
//

import UIKit
// when this is outside of a class, it's just global.could be written anywhere
protocol MedicationTableViewCellDelegate: AnyObject {
    //protocol. Anyone that signs up for this job (one of these delegates) needs to do this:
    func medicationWasTakenButtonTapped(medication: Medication, wasTaken: Bool)
}

class MedicationTableViewCell: UITableViewCell {
    
    weak var delegate: MedicationTableViewCellDelegate?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wasTakenButton: UIButton!
    
    private var medication: Medication?
    private var wasTakenToday: Bool = false
    
    @IBAction func wasTakenButtonTapped(_ sender: UIButton) {
        guard let medication = medication
        else { return }
        
        wasTakenToday.toggle()
        delegate?.medicationWasTakenButtonTapped(medication: medication, wasTaken: wasTakenToday)
        print("Cell: Was taken button tapped")
    }
    
    func configure(with medication: Medication) {
        self.medication = medication
        wasTakenToday = medication.wasTakenToday()
        
        nameLabel.text = medication.name
        timeLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date()) // if for some weird reason there isn't a date, show this medication.
        let image = wasTakenToday ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        wasTakenButton.setImage(image, for: .normal)
    }
    
    
       
    
}
