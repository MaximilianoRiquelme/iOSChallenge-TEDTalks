//
//  TalkViewController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 04/08/2021.
//

import UIKit
import WebKit

class TalkViewController: UIViewController {
    
    @IBOutlet weak var video: WKWebView!
    @IBOutlet var talkTitle: UILabel!
    @IBOutlet var descript: UILabel!
    @IBOutlet var views: UILabel!
    @IBOutlet var publishedDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
