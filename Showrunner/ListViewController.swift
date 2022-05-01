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
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        shows.urlString = "\(shows.urlString+searchText)"
        
        shows.getData {
            DispatchQueue.main.async {
                self.sortTable()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        let selectedIndexPath = tableView.indexPathForSelectedRow!
        destination.show = shows.showArray[selectedIndexPath.row].show
    }
    
    func sortTable() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            shows.showArray.sort(by: {$0.show.name < $1.show.name})
        case 1:
            shows.showArray.sort(by: {$0.show.rating?.average ?? 0.0 > $1.show.rating?.average ?? 0.0})

        default:
            print("ERROR: this should never happen")
        }
        tableView.reloadData()
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        sortTable()
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

