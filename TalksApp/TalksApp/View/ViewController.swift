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
    
    let searchController = UISearchController()
    let talksController = TalksController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadSearchBar()
        self.loadTableView()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func loadTableView() {
        let nib = UINib(nibName: "MiniatureTalkCell", bundle: nil)
        talksTableView.register(nib, forCellReuseIdentifier: "MiniatureTalkCell")
        
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
            let destinationView = segue.destination as? TalkDetailView
            
            if searchController.isActive {
                if let selectedTalk = talksController.searchArray?[indexPath!.row] {
                    destinationView?.loadTalk(selectedTalk: selectedTalk)
                }
            }
            else {
                if let selectedTalk = talksController.talksArray?[indexPath!.row] {
                    destinationView?.loadTalk(selectedTalk: selectedTalk)
                }
            }
            
            self.talksTableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    //Sets the amount of rows on the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            if let rows = talksController.searchArray?.count {
                return rows
            }
        }
        else {
            if let rows = talksController.talksArray?.count {
                return rows
            }
        }
        
        return 0
    }
    
    //Loads all cells in order
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiniatureTalkCell", for: indexPath) as! MiniatureTalkCell
        
        //Change the cell with the proper information
        if searchController.isActive {
            if let talk = talksController.searchArray?[indexPath.row] {
                cell.updateCell(talk: talk)
            }
        }
        else {
            if let talk = talksController.talksArray?[indexPath.row] {
                cell.updateCell(talk: talk)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating
{
    func loadSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBarAux = searchController.searchBar
        let searchText = searchBarAux.text!
        
        filterForSeachText(searchText: searchText)
    }
    
    func filterForSeachText(searchText: String) {
        
        talksController.searchArray = talksController.talksArray?.filter
        {
            Talk in
            if(searchController.searchBar.text != "") {
                let searchTextMatch = Talk.name.lowercased().contains(searchText.lowercased())
                return searchTextMatch
            }
            else {
                 return false
            }
        }
    }
}
