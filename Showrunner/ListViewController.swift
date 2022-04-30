//
//  ViewController.swift
//  Showrunner
//
//  Created by Chris Bond on 4/30/22.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var shows = Shows()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        shows.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
    }
    

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.showArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(shows.showArray[indexPath.row].show.name)"
        if let rating = shows.showArray[indexPath.row].show.rating?.average {
            cell.detailTextLabel?.text = "\(rating)"
        } else {
            cell.detailTextLabel?.text = "-"

        }
        return cell
    }
    
 
    
    
}

