//
//  UITableViewController.swift
//  CinemoTask
//
//  Created by Vinculum on 6/5/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit

class UITableViewControllerCinemo: UITableViewController {
    
    var imageDataList = [ImageData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        tableView.rowHeight = 500
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageDataList.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellCinemo", for: indexPath) as? TableViewCellCinemo else {
        fatalError("The dequeued cell is not an instance of TableViewCellCinemo.")
        }
        // Configure the cell...
        let images = imageDataList[indexPath.row]
        cell.imageViewPanel.image = images.photo
        return cell
    }
    
    private func loadSampleData() {
        for index in 1...10 {
            let imageName = "image"+String(index)
            imageDataList.append(ImageData(photo: UIImage(named: imageName))!)
        }
    }
}
