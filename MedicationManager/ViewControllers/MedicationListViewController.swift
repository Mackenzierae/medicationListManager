//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Mackenzie Wacker on 12/8/22.
//

import UIKit

class MedicationListViewController: UIViewController {
    
    @IBOutlet weak var medicationListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MedicationController.shared.fetchMedications()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        medicationListTableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
    }
    
    
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMedicationDetails",
           let indexPath = medicationListTableView.indexPathForSelectedRow,
           let destination = segue.destination as? MedicationDetailViewController {
            let medication = MedicationController.shared.medications[indexPath.row]
            destination.medication = medication
            
        } else if segue.identifier == "toNewMedication" {
            // nothing to do. title is set
        }
    }
    

}

extension MedicationListViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.medications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell else {return UITableViewCell()}
        
        let medication = MedicationController.shared.medications[indexPath.row]
        cell.configure(with: medication)
        cell.delegate = self
        return cell
    }
}

extension MedicationListViewController: UITableViewDelegate {}

// second part of what we did over in custom cell
//this allows us to do lne 62 - cell.delegate = self
extension MedicationListViewController: MedicationTableViewCellDelegate {
    func medicationWasTakenButtonTapped(medication: Medication, wasTaken: Bool) {
        MedicationController.shared.markMedicationTaken(medication: medication, wasTaken: wasTaken)
        medicationListTableView.reloadData()
    }
}
