//
//  ViewController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 03/08/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var tedTalksTableView: UITableView!
    
    var talksController: TalksController = TalksController.instance
    
    override func viewDidLoad() {
        super.viewDidLoad() // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "MiniatureTalk", bundle: nil)
        tedTalksTableView.register(nib, forCellReuseIdentifier: "MiniatureTalk")
        
        tedTalksTableView.delegate = self
        tedTalksTableView.dataSource = self
        
        tedTalksTableView.rowHeight = UITableView.automaticDimension
        tedTalksTableView.estimatedRowHeight = 600
        
        talksController.loadTalks()
        tedTalksTableView.reloadData()
    }

    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something perhaps
    }
    
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = talksController.tedTalks?.count else {
            return 0
        }
        
        return rows
    }
    
    //Loads all cells in order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiniatureTalk", for: indexPath) as! MiniatureTalk
        
        //Change the cell with the proper information
        guard let talk = talksController.tedTalks?[indexPath.row] else{
            return cell
        }
        
        cell.updateCell(talk: talk)
    
        return cell
    }
}

