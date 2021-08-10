//
//  AddLocationViewController.swift
//  WeatherAppFull
//
//  Created by Melih Cüneyter on 5.08.2021.
//

import UIKit

class LocationListViewController: UIViewController {
    @IBOutlet weak var addLocationTextField: UITextField!
    @IBOutlet weak var locationTableView: UITableView!
    var locationNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        locationTableView.backgroundColor = .lightGray
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationNames = UserDefaults.standard.array(forKey: "newLocation") as? [String] ?? ["Veri Yok"]
        locationTableView.reloadData()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        locationNames.append("\(addLocationTextField.text!)")
        UserDefaults.standard.set(locationNames, forKey: "newLocation")
        locationTableView.reloadData()
        addLocationTextField.text?.removeAll()
        print(locationNames)
    }
}

extension LocationListViewController: UITableViewDelegate {
    
}

extension LocationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locationNames[indexPath.row]
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationNames.remove(at: indexPath.row)
            locationTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            UserDefaults.standard.set(locationNames, forKey: "newLocation")
            UserDefaults.standard.synchronize()
        }
    }
}
