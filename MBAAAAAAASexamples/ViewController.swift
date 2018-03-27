//
//  ViewController.swift
//  MBAAAAAAASexamples
//
//  Created by Eloe,Wendy C on 3/15/18.
//  Copyright © 2018 Eloe,Wendy C. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func store(sender: AnyObject) {
        /*let movie = PFObject(className: "Movie")
        movie["title"] = "Star Wars 78"
        movie["year"] = 2134
        movie["director"] = "Lucas VIII"*/
        
        let movie = Movie()
        movie.title = "Airplane"
        movie.year = 1980
        movie.producer = "Davisen"
        
        movie.saveInBackground(block: { (success, error) -> Void in
            if success {
                self.displayOKAlert(title: "Success!", message:"Movie saved.")
            } else {
                print(error as Any)
            }
        })
    }
    
    func displayOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    var movies:[Movie] = []
    
    @IBAction func fetch(sender:AnyObject) {
        let query = PFQuery(className:"Movie") // Fetches all the Movie objects
        query.findObjectsInBackground { // what happened to the ( ) ?
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                self.displayOKAlert(title: "Success!",
                                    message:"Retrieved \(objects!.count) objects.")
                self.movies = objects as! [Movie]
                // Do something with the found objects
                // Like display them in a table view.
                //self.moviesTV.reloadData()
                for movie in self.movies {
                    print(movie.title)
                }
            } else {
                // Log details of the failure
                self.displayOKAlert(title: "Oops", message: "\(error!)")
            }
        }
    }
}

