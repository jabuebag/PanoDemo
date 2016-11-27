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
        var officePano = PanoModel(name: "office.jpg", panoName: "test12.jpg")
        var diningPano = PanoModel(name: "dining.jpg", panoName: "dining.jpg")
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
        return panoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PanoCell", for: indexPath) as! MainTableViewCell
        cell.panoImg.image = UIImage(named: panoArray[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sphereView: SphereViewController = storyboard.instantiateViewController(withIdentifier: "SphereViewController") as! SphereViewController
        sphereView.panoModel = panoArray[indexPath.row]
        self.present(sphereView, animated: true, completion: nil)
    }
}
