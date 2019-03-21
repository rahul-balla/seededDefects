//
//  matchesTableViewController.swift
//  Tindents
//
//  Created by Andre Chang on 2/3/19.
//  Copyright © 2019 Rahul Balla. All rights reserved.
//

import UIKit

class matchesTableViewController: UITableViewController {
    
    var firstName : [String: Any] = [
        "name" : "Ryan Gosling",
        "age" : 23,
        "subjects" : ["CS", "MATH"],
        "tutorEmail" : "ryan@gosling.com",
        "rating" : "4.5/5",
        "description" : "hello",
        "picture" : UIImage(named: "ryan")!,
        "charge" : 23.5
    ]
    
    var secondName : [String: Any] = [
        "name" : "Tom Cruise",
        "age" : 60,
        "subjects" : ["PHIL", "CS"],
        "tutorEmail" : "tom@cruise.com",
        "rating" : "3.8/5",
        "description" : "my name is Tom Cruise",
        "picture" : UIImage(named: "tomCruise")!,
        "charge" : 30.98
    ]
    
    var thirdName : [String: Any] = [
        "name" : "Will Smith",
        "age" : 89,
        "subjects" : ["STAT", "CS"],
        "tutorEmail" : "will@smith.com",
        "rating" : "2.1/5",
        "description" : "CS 354 (OS) sucks!",
        "picture" : UIImage(named: "willSmith")!,
        "charge" : 45.98
    ]
    
    var tutors: [Tutor] = []

    @IBOutlet var matchesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tutor1 = Tutor(dictionary: firstName)
        let tutor2 = Tutor(dictionary: secondName)
        let tutor3 = Tutor(dictionary: thirdName)
        
        self.tutors.append(tutor1)
        self.tutors.append(tutor2)
        self.tutors.append(tutor3)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tutors.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as! matchesTableViewCell

        let tutor = tutors[indexPath.row]
        cell.tutor = tutor
        
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let tutor = tutors[indexPath.row]
            let detailViewController = segue.destination as! profileViewController
            detailViewController.tutor = tutor
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//        if let indexPath = tableView.indexPath(for: cell){
//            let movie = movies[indexPath.row];
//            let detailViewController = segue.destination as! DetailViewController
//            detailViewController.movie = movie;
//        }
//
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
