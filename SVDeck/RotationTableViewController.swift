//
//  RotationTableViewController.swift
//  SVDeck
//
//  Created by 張峻浩 on 2018/1/11.
//  Copyright © 2018年 張峻浩. All rights reserved.
//

import UIKit

class RotationTableViewController: UITableViewController {

    var decks = [Deck]()
    
    @IBAction func goBackToDeckIndex(segue: UIStoryboardSegue){
        if let controller = segue.source as? AddDeckTableViewController {
            if controller.deckNumber != nil {
                decks[controller.deckNumber!] = controller.deck
            }
            else {
                decks.append(controller.deck)
            }
            Deck.saveToFile(decks: decks, mode: "Rotation")
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        decks.remove(at: indexPath.row)
        Deck.saveToFile(decks: decks, mode: "Rotation")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let decks = Deck.readFromFile(mode: "Rotation") {
            self.decks = decks
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return decks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SVCell", for: indexPath) as? SVTableViewCell else {assert(false)}

        // Configure the cell...
        
        let deck = decks[indexPath.row]
        cell.deckName.text = deck.name
        cell.typeIcon.image = UIImage(named:"\(deck.type)")

        return cell
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? DeckViewController {
            if let selected = tableView.indexPathForSelectedRow{
                controller.deckNumber = selected.row
                controller.deck = decks[selected.row]
            }
        }
    }
}
