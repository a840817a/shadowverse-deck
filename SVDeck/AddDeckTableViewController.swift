//
//  AddDeckTableViewController.swift
//  SVDeck
//
//  Created by 張峻浩 on 2018/1/12.
//  Copyright © 2018年 張峻浩. All rights reserved.
//

import UIKit

class AddDeckTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var deck: Deck!
    var isChangeImage = false;
    var deckNumber:Int?
    
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var portalTextField: UITextField!
    @IBOutlet weak var deckImegeButton: UIButton!
    
    @IBAction func deckImegeButtonPressed(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        deckImegeButton.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: .normal)
        isChangeImage = true
        dismiss(animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let deckType = ["Elf", "Royal", "Witch", "Dragon", "Necromancer", "Vampire", "Bishop", "Nemesis"]
        
        let portal:URL

        guard let name = nameTextField.text, name.count > 0 else {
            showAlert(message: "請輸入名字")
            return false
        }
        
        let type = deckType[typeSegmentedControl.selectedSegmentIndex]
        
        guard let url = portalTextField.text, url.count > 0 else {
            showAlert(message: "請輸入網址")
            return false
        }
        if url.hasPrefix("https://") {
            guard isMatches(regex: "(https?://)?shadowverse-portal.com/deck/[0-9_\\-\\.a-zA-z\\=]+", text: url) else {
                showAlert(message: "請輸入正確網址")
                return false
            }
            portal = URL(string: url)!
        } else {
            guard isMatches(regex: "(https?://)?shadowverse-portal.com/deck/[0-9_\\-\\.a-zA-z\\=]+", text: url) else {
                showAlert(message: "請輸入正確網址")
                return false
            }
            portal = URL(string: "https://" + url)!
        }
        
        var imageName: String?
        if isChangeImage {
            imageName = "\(Date().timeIntervalSinceReferenceDate)"
            let url = Deck.documentsDirectory.appendingPathComponent(imageName!)
            let data = UIImageJPEGRepresentation(deckImegeButton.backgroundImage(for: .normal)!, 0.9)
            try? data?.write(to: url)
        }
        else {
            if deckNumber != nil{
                imageName = deck.imageName
            }
        }
        
        deck = Deck(name: name, portal: portal, type: type, imageName: imageName)
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if deckNumber != nil{
            titleBar.title = "編輯牌組"
            nameTextField.text = deck.name
            typeSegmentedControl.selectedSegmentIndex = AddDeckTableViewController.typeNameToIndex(type: deck.type)
            portalTextField.text = deck.portal.absoluteString
            deckImegeButton.setBackgroundImage(deck.image, for: .normal)
        }
        else
        {
            titleBar.title = "新增牌組"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(message: String) {
        let controller = UIAlertController(title: "錯誤", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
    func isMatches(regex: String, text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            return regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.utf16.count)) != nil
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    static func typeNameToIndex (type: String) -> Int {
        switch type {
        case "Elf":
            return 0
        case "Royal":
            return 1
        case "Witch":
            return 2
        case "Dragon":
            return 3
        case "Necromancer":
            return 4
        case "Vampire":
            return 5
        case "Bishop":
            return 6
        case "Nemesis":
            return 7
        default:
            return 0
        }
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
