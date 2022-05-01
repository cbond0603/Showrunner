//
//  SearchViewController.swift
//  Showrunner
//
//  Created by Chris Bond on 5/1/22.
//

import UIKit
import AVFoundation

class SearchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchShowLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        
        imageView.alpha = 0.0
        searchTextField.alpha = 0.0
        searchShowLabel.alpha = 0.0
        searchButton.alpha = 0.0
        
        playSound(name: "tv-startup-sound")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 5.0, delay: 4.0, animations: {self.searchButton.alpha = 1.0; self.imageView.alpha = 1.0; self.searchShowLabel.alpha = 1.0; self.searchTextField.alpha = 1.0})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var searchText = searchTextField.text!
        searchText = searchText.replacingOccurrences(of: " ", with: "%20")
        let destination = segue.destination as! ListViewController
        destination.searchText = searchText
    }
    
    func playSound(name: String){
            if let sound = NSDataAsset(name: name){
                do {
                    try audioPlayer = AVAudioPlayer(data: sound.data)
                    audioPlayer.play()
                } catch {
                    print("Error: \(error.localizedDescription) could not read")
                }
            } else {
                print("Error could not read")
            }
        }

}
