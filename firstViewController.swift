//
//  firstViewController.swift
//  todolist
//
//  Created by 蔡顯達 on 2022/9/30.
//

import UIKit

class firstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var toDos = [String]()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        if let loadtodos = UserDefaults.standard.stringArray(forKey: "todos") {
            toDos = loadtodos
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = toDos[indexPath.row]
        cell.textLabel?.textColor = .red
        cell.textLabel?.font = UIFont(name: "arial", size: 24)
        return cell
    }
    //滑動刪除的函式
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            UserDefaults.standard.set(toDos, forKey: "todos")
            myTableView.reloadData()
        }
    }
    //不要反白的方法
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    //按到驚嘆號的實作
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let seconvcl = tabBarController?.viewControllers?[1] as? secondViewController {
            seconvcl.inForFromView1 = indexPath.row
        }
        tabBarController?.selectedIndex = 1
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
