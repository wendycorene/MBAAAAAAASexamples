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
    
    @IBAction func remove (sender:AnyObject) {
        if self.movies.count > 0 {
        let movieToGo = self.movies[0]
        movieToGo.deleteInBackground(block:
            {(success,error) in
                self.displayOKAlert(title: "Success!",
                                    message:"So long, and thanks for all the fish")
        })
        }
    }
    
    @IBAction func addActor(sender:AnyObject) {

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
                let actor = Actor()
                actor.name = "Harrison Ford"
                actor.starredIn = self.movies
                actor.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        self.displayOKAlert(title: "Success!", message:"Movie saved.")
                    } else {
                        print(error as Any)
                    }
                })
            } else {
                // Log details of the failure
                self.displayOKAlert(title: "Oops", message: "\(error!)")
            }
        }
        
    }
    
    @IBAction func register(sender: AnyObject) {
        // Defining the user object
        let user = PFUser()
        user.username = "bob"
        user.password = "bob"
        user.email = "bob@bob.com"
        
        user.signUpInBackground(block: {
            (success, error) -> Void in
            if let error = error as Error? {
                let errorString = error.localizedDescription
                // In case something went wrong, use errorString to get the error
                self.displayOKAlert(title: "Something has gone wrong", message:"\(errorString)")
            } else {
                // Everything went okay
                self.displayOKAlert(title: "Success!", message:"Registration was successful")
                let emailVerified = user["emailVerified"]
                if emailVerified != nil && (emailVerified as! Bool) == true {
                    // Everything is fine
                }
                else {
                    // The email has not been verified, so logout the user
                    PFUser.logOut()
                    print("User logged out")
                }
            }
        })
        
    }
    
    @IBAction func login(sender: AnyObject) {
        let name = "bob"
        let password = "bob"
        PFUser.logInWithUsername(inBackground: name, password: password,
                                 block:{(user, error) -> Void in
                                    if error != nil{
                                        print(error as Any)
                                    }
                                    else {
                                        // Everything went alright here
                                        self.displayOKAlert(title: "Success!", message:"Login successful")
                                    }
        })
    }
}

