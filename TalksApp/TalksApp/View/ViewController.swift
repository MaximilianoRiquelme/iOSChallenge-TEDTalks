//
//  ViewController.swift
//  TalksApp
//
//  Created by Maximiliano Riquelme Vera on 03/08/2021.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var talksTableView: UITableView!
    
    let talksController = TalksControllerImp()
    var searching = false
    var filters: [TalkFilter] = [TalkFilter.description, TalkFilter.mainSpeaker, TalkFilter.name, TalkFilter.speakerOccupation, TalkFilter.tags, TalkFilter.title]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadSearchBar()
        self.loadPickerView()
        self.loadTableView()
    }
}

//Adds the required functions to manage the TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func loadTableView() {
        let nib = UINib(nibName: "TalkCell", bundle: nil)
        talksTableView.register(nib, forCellReuseIdentifier: "TalkCell")
        
        talksTableView.delegate = self
        talksTableView.dataSource = self
        
        talksTableView.rowHeight = UITableView.automaticDimension
        talksTableView.estimatedRowHeight = 600
        
        talksController.loadAllTalks { result in
            self.talksTableView.reloadData()
        }
    }
        
    //Called when a cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "talkDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "talkDetailSegue") {
            
            let indexPath = self.talksTableView.indexPathForSelectedRow
            let destinationView = segue.destination as? TalkDetailedView
            
            let selectedTalk = searching ? talksController.filteredTalks?[indexPath!.row] : talksController.talks?[indexPath!.row]
            let detailedController = DetailControllerImp(talk: selectedTalk!)
            destinationView?.loadDetailController(detailController: detailedController)
            
            self.talksTableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rows: Int?
        
        rows = searching ? talksController.filteredTalks?.count : talksController.talks?.count
        
        return rows ?? Int.zero
    }
    
    //Loads all cells in order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TalkCell", for: indexPath) as? TalkCell
        else {
            return UITableViewCell()
        }
        
        //Change the cell with the proper information
        if searching {
            if let talk = talksController.filteredTalks?[indexPath.row] {
                cell.updateCell(talk: talk)
            }
        }
        else {
            if let talk = talksController.talks?[indexPath.row] {
                cell.updateCell(talk: talk)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//Adds the required means to manage the SearchBar
extension ViewController: UISearchBarDelegate
{
    func loadSearchBar() {
        self.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let filter = pickerView.selectedRow(inComponent: 0).description
        self.talksController.filterTalks(filter: filter, searchText: searchText)
        searching = true
        self.talksTableView.reloadData()
    }
}

//Adds the required means to manage the PickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func loadPickerView() {
        self.pickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.text = filters[row].rawValue
        label.sizeToFit()
        return label
    }
}
