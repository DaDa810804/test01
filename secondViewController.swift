//
//  secondViewController.swift
//  todolist
//
//  Created by 蔡顯達 on 2022/9/30.
//

import UIKit

class secondViewController: UIViewController, UITextFieldDelegate{
    var inForFromView1:Int?
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        if sender.text != "" {
            myButton.setTitle("OK", for: .normal)
        }else {
            myButton.setTitle("BACK", for: .normal)
        }
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let text = myTextInput.text {
            guard let fviewcon = tabBarController?.viewControllers?[0] as? firstViewController else { return }
            if text != "" {
                if inForFromView1 != nil {
                    fviewcon.toDos[inForFromView1!] = text
                    inForFromView1 = nil
                } else {
                    fviewcon.toDos.append(text)
                }
                fviewcon.myTableView.reloadData()
                UserDefaults.standard.set(fviewcon.toDos, forKey: "todos")
            } else {
                if inForFromView1 != nil {
                    fviewcon.toDos.remove(at: inForFromView1!)
                    fviewcon.myTableView.reloadData()
                    UserDefaults.standard.set(fviewcon.toDos, forKey: "todos")
                    inForFromView1 = nil
                }
            }
        }
        myTextInput.text = ""
        myButton.setTitle("BACK", for: .normal)
        self.tabBarController?.selectedIndex = 0
        
    }
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myTextInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTextInput.becomeFirstResponder()
        myTextInput.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if inForFromView1 != nil {
             if let fstvcl = tabBarController?.viewControllers?[0] as? firstViewController {
                 myTextInput.text = fstvcl.toDos[inForFromView1!]
                 myButton.setTitle("OK", for: .normal)
             }
         }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonPressed(UIButton())
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
