//
//  ViewController.swift
//  Contact-JSON
//
//  Created by Tarun Meena on 14/02/20.
//  Copyright © 2020 Mihir Vyas. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
   
    let tableView = UITableView()
    let CustomView = UIView()
    var arreRes = [[String: AnyObject]]()
    
    fileprivate func setupTableView() {
      self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.black
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    fileprivate func setupCustomView() {
        self.view.addSubview(CustomView)
        CustomView.backgroundColor = UIColor.cyan
       CustomView.translatesAutoresizingMaskIntoConstraints = false
       CustomView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       CustomView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
       CustomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       CustomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.barTintColor = _ColorLiteralType(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:_ColorLiteralType(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupNavigationBar()
        tableView.dataSource = self
        tableView.delegate = self
        setupTableView()
        getRequest()
    }
    
    func getRequest() {
        Alamofire.request("https://api.androidhive.info/contacts").responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let contactData = swiftyJsonVar["contacts"].arrayObject {
                    self.arreRes = contactData as! [[String: AnyObject]]
                }
             
                if self.arreRes.count > 0 {
                  self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arreRes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell?.backgroundColor = UIColor.black
        var dict = arreRes[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        cell?.detailTextLabel?.textColor = UIColor.white
        cell?.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 21.0)
        cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell?.textLabel?.text = dict["name"] as? String
        cell?.detailTextLabel?.text = dict["email"] as? String
        return cell!
    }

}
