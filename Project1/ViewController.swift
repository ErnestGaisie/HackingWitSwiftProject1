//
//  ViewController.swift
//  Project1
//
//  Created by APPLE on 2022/1/25.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var sortedPictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
        
        sortedPictures = pictures.sorted()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = sortedPictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                // 2: success! Set its selectedImage property
                vc.selectedImage = sortedPictures[indexPath.row]
                vc.selectedImageIndex = indexPath.row
                vc.imagesCount = sortedPictures.count
                

                // 3: now push it onto the navigation controller
                navigationController?.pushViewController(vc, animated: true)
            }
    }


}

