//
//  DetailViewController.swift
//  Showrunner
//
//  Created by Chris Bond on 5/1/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var show: Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard show != nil else {
            print("Show is nil should never happen")
            return
        }
        updateUserInterface()

    }
    
    func updateUserInterface() {
        nameLabel.text = show.name
        networkLabel.text = show.network?.name ?? ""
        languageLabel.text = show.language ?? ""
        show.summary = show.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression,range: nil)
        descriptionTextView.text = show.summary ?? ""
        
        if let rating = show.rating?.average {
            ratingLabel.text = "\(rating)"
        } else {
            ratingLabel.text = "-"
        }
        
        var genresList = ""
        if show.genres != nil {
            for genre in show.genres! {
                genresList += "\(genre)\n"
            }
            // to remove extra line because of \n
            if genresList != "" {
                genresList.removeLast()
            }
        }
        genreLabel.text = genresList
        guard let url = URL(string: show.image?.original ?? "") else {return}
        do {
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        } catch {
            print("ERROR: Could not get image from \(url)")
        }
        
        
    }


}
