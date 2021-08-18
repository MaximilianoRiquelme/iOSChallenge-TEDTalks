//
//  TalkDetailedView.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 11/08/2021.
//

import UIKit
import WebKit

class TalkDetailedView: UIViewController
{
    
    @IBOutlet weak var talkTitle: UILabel!
    @IBOutlet weak var video: WKWebView!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var tags: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func loadDetailController(detailController: DetailController)
    {
        DispatchQueue.main.async {
            self.talkTitle.text = detailController.title
            self.views.text = detailController.views
            self.publishedDate.text = detailController.publishedDate
            self.name.text = detailController.name
            self.descript.text = detailController.description
            self.tags.text = detailController.tags
            
            if let url = detailController.url {
                self.video.load(URLRequest(url: url))
            }
        }
    }
}
