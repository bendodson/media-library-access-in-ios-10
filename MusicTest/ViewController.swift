//
//  ViewController.swift
//  MusicTest
//
//  Created by Ben Dodson on 02/08/2016.
//  Copyright © 2016 Dodo Apps. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.runMediaLibraryQuery()
            } else {
                self.displayMediaLibraryError()
            }
        }
    }
    
    func runMediaLibraryQuery() {
        let query = MPMediaQuery.songs()
        if let items = query.items, let item = items.first {
            NSLog("Title: \(item.title)")
        }
    }
    
    func displayMediaLibraryError() {
        var error: String
        switch MPMediaLibrary.authorizationStatus() {
        case .restricted:
            error = "Media library access restricted by corporate or parental settings"
        case .denied:
            error = "Media library access denied by user"
        default:
            error = "Unknown error"
        }
        
        let controller = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        present(controller, animated: true, completion: nil)
    }
    

    


}

