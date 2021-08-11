//
//  TalkDetailViewController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 11/08/2021.
//

import UIKit
import WebKit

class TalkDetailView: UIViewController
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
    
    func loadTalk(selectedTalk: Talk)
    {
        DispatchQueue.main.async {
            self.talkTitle.text = selectedTalk.title
            self.views.text = "# of views \(String(describing: selectedTalk.views))"
            self.publishedDate.text = "Published Date: \(String(describing: selectedTalk.publishedDate))"
            self.name.text = selectedTalk.name
            self.descript.text = selectedTalk.description
            self.tags.text = "Tags: \(String(describing: selectedTalk.tags.description))"
            
            if let url = URL(string: selectedTalk.url) {
                self.video.load(URLRequest(url: url))
            }
        }
    }
}
