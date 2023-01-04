//
//  Medication+convenience.swift
//  MedicationManager
//
//  Created by Mackenzie Wacker on 12/8/22.
//

import CoreData

//video time: ~ 1:22
extension Medication {
    @discardableResult convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
    }
    
    func wasTakenToday() -> Bool {
        if (takenDates as? Set<TakenDate>)?.contains(where: { takenDate in
            guard let date = takenDate.date
            else { return false }
            
            return Calendar.current.isDate(date, inSameDayAs: Date())
        }) == true { // have to explicitly do this because takenDates was optional.
            return true
        } else {
            return false
        }
    }
}
