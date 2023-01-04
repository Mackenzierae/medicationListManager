//
//  dateFormatter+Extras.swift
//  MedicationManager
//
//  Created by Mackenzie Wacker on 12/9/22.
//

import Foundation

extension DateFormatter {
    static let medicationTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
