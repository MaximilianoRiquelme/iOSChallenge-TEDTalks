//
//  MiniatureTalk.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 04/08/2021.
//

import UIKit
import WebKit

class MiniatureTalk: UITableViewCell {
    
    @IBOutlet weak var thumbnail: WKWebView!
    @IBOutlet var mainSpeaker: UILabel!
    @IBOutlet var descript: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(talk: Talk)
    {
        guard let url = URL(string: talk.url)
        else {
            return
        }
        self.thumbnail.load(URLRequest(url: url))
        
        self.mainSpeaker.text = "Main Speaker: \(talk.mainSpeaker)"
        self.descript.text = talk.description
    }
}
