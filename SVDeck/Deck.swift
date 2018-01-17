//
//  Deck.swift
//  SVDeck
//
//  Created by 張峻浩 on 2018/1/11.
//  Copyright © 2018年 張峻浩. All rights reserved.
//

import Foundation
import UIKit

struct Deck: Codable {
    var name: String
    var portal: URL
    var type: String
    var imageName: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func saveToFile(decks: [Deck], mode: String) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(decks) {
            let url = Deck.documentsDirectory.appendingPathComponent(mode)
            try? data.write(to: url)
        }
    }
    
    static func readFromFile(mode: String) -> [Deck]? {
        let propertyDecoder = PropertyListDecoder()
        let url = Deck.documentsDirectory.appendingPathComponent(mode)
        if let data = try? Data(contentsOf: url), let decks = try? propertyDecoder.decode([Deck].self, from: data) {
            return decks
        } else {
            return nil
        }
    }
    
    var image: UIImage? {
        if let imageName = imageName {
            let url = Deck.documentsDirectory.appendingPathComponent(imageName)
            return UIImage(contentsOfFile: url.path)
        } else {
            return #imageLiteral(resourceName: "Shadowverse")
        }
    }
}
