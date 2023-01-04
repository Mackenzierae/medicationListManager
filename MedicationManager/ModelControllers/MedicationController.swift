//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Mackenzie Wacker on 12/8/22.
//

import CoreData

class MedicationController {
    
    static let shared = MedicationController()
    private init() {}
    
//    lazy means it won't be run when the initializer runs'
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true) // a predicate can be requested to return specific things.... like all contacts starting with letter K. but when marked 'true' it just returns everything
        return request
    }()
    
    var medications: [Medication] = []
    
    
    func create(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        medications.append(medication)
        CoreDataStack.saveContext()
        
    }
    
    func fetchMedications() {
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        print(medications.count)
        self.medications = medications //
    }
    
    func updateMedication(medication: Medication, name: String, timeOfDay: Date) {
        medication.name = name
        medication.timeOfDay = timeOfDay // nothing has happened in memory yet
        CoreDataStack.saveContext()
    }
    
//    this works for adding one and removing one
    func markMedicationTaken(medication: Medication, wasTaken: Bool) {
        if wasTaken { // == if true
            TakenDate(date: Date(), medication: medication)
        } else { // uncheck
            //delete
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")
            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date
                else { return false }
                
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
            }
        }
        CoreDataStack.saveContext()
    }
    func deleteMedication() {
    }
}
