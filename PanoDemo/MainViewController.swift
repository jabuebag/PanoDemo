//
//  MainViewController.swift
//  PanoDemo
//
//  Created by Kris Yang on 2016-11-25.
//  Copyright © 2016 Kris Yang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var panoArray: [PanoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var officePano = PanoModel(name: "office", originImg: UIImage(named: "office.jpg")!)
        var diningPano = PanoModel(name: "dining", originImg: UIImage(named: "dining.jpg")!)
        panoArray.append(officePano)
        panoArray.append(diningPano)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PanoCell", for: indexPath) as! MainTableViewCell
        cell.panoImg.image = panoArray[indexPath.row].originImg
        return cell
    }
}
