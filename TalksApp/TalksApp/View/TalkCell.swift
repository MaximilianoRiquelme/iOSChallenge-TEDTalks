//
//  MiniatureTalk.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 04/08/2021.
//

import UIKit
import WebKit

class TalkCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: WKWebView!
    @IBOutlet var mainSpeaker: UILabel!
    @IBOutlet var descript: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(talk: Talk)
    {
        //Updates texts
        self.mainSpeaker.text = "Main Speaker: \(talk.mainSpeaker)"
        self.descript.text = talk.description
        
        //Finally, loads "thumbnail" url
        if let url = URL(string: talk.url) {
            self.thumbnail.load(URLRequest(url: url))
        }
    }
}
