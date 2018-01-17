//
//  DeckViewController.swift
//  SVDeck
//
//  Created by 張峻浩 on 2018/1/17.
//  Copyright © 2018年 張峻浩. All rights reserved.
//

import UIKit
import SafariServices

class DeckViewController: UIViewController {

    var deck:Deck!
    var deckNumber:Int!
    
    @IBOutlet weak var nameBar: UINavigationItem!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var portalButton: UIButton!
    @IBOutlet weak var deckImageView: UIImageView!
    
    @IBAction func portalButtonPressed(_ sender: Any) {
        let sfViewController = SFSafariViewController(url: deck.portal)
        self.present(sfViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameBar.title = deck.name
        nameLable.text = deck.name
        deckImageView.image = deck.image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? AddDeckTableViewController {
            controller.deckNumber = deckNumber
            controller.deck = deck
        }
    }

}
