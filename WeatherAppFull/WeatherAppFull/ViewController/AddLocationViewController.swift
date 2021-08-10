//
//  AddLocationViewController.swift
//  WeatherAppFull
//
//  Created by Melih Cüneyter on 5.08.2021.
//

import UIKit

class AddLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addLocationTextField: UITextField!
    @IBOutlet weak var locationTableView: UITableView!
    
    var locationArray = [String]()
    var userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationTableView.backgroundColor = UIColor.lightGray
        view.backgroundColor = UIColor.lightGray

        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.reloadData()

        locationArray = UserDefaults.standard.array(forKey: "newLocation") as? [String] ?? ["Veri Yok"]        
        
    }
    @IBAction func addButton(_ sender: UIButton) {
        locationArray.append("\(addLocationTextField.text!)")
        UserDefaults.standard.set(locationArray, forKey: "newLocation")
        locationTableView.reloadData()
        addLocationTextField.text?.removeAll()
        print(locationArray)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = locationArray[indexPath.row]
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationArray.remove(at: indexPath.row)
            locationTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            UserDefaults.standard.set(locationArray, forKey: "newLocation")
            UserDefaults.standard.synchronize()
        }
    }


}
