//
//  LanguageViewController.swift
//  Prenly
//
//  Created by Luka Ivkovic on 11/09/2021.
//

import UIKit

class LanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nextBtn: UIButton!
    var pickerData: [String] = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 37/255, green: 73/255, blue: 130/255, alpha: 1)])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["English", "Italy", "French"]
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        nextBtn.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        if UserDefaults.standard.object(forKey: "language") != nil {
            showTabBarScreen()
            Constants.COUNTRY_CODE = UserDefaults.standard.string(forKey: "language")!
        }
            
    }
    
    func showTabBarScreen() {
        let homeView = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            homeView.modalPresentationStyle = .fullScreen
            present(homeView, animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        let selectedValue = pickerData[pickerView.selectedRow(inComponent: 0)]
        let formatted = selectedValue.prefix(2).lowercased()
        UserDefaults.standard.setValue(formatted, forKey: "language")
        Constants.COUNTRY_CODE = formatted
        showTabBarScreen()
    }

}
