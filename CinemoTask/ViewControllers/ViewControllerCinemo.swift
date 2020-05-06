//
//  ViewControllerCinemo.swift
//  CinemoTask
//
//  Created by Vinculum on 6/5/2020.
//  Copyright © 2020 Anubhav. All rights reserved.
//

import UIKit

class ViewControllerCinemo: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewImages: UITableView!
    
    var imageDataList = [ImageData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData()
        tableViewImages?.delegate = self
        tableViewImages?.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.rowHeight = 500
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataList.count
    }

     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellCinemo", for: indexPath) as? TableViewCellCinemo else {
                fatalError("The dequeued cell is not an instance of TableViewCellCinemo.")
           }
           let images = imageDataList[indexPath.row]
           cell.imageViewPanel.image = images.photo
           return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.item)
        let imageNameToShare = "image"+String(indexPath.item+1)
        let image = UIImage(named: imageNameToShare)
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
      
    private func loadSampleData() {
        for index in 1...10 {
            let imageName = "image"+String(index)
            imageDataList.append(ImageData(photo: UIImage(named: imageName))!)
        }
    }
    
}
