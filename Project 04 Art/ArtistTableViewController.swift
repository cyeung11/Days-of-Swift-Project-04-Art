//
//  ArtistTableViewController.swift
//  Project 04 Art
//
//  Created by Chris on 21/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class ArtistTableViewController: UITableViewController, UISplitViewControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    let model = Model()
    var searchedModel = [Artists.ArtistDetail]()
    var searchController = UISearchController(searchResultsController: nil)
    lazy var before19 = model.info == nil ?[Artists.ArtistDetail]() :[(model.info?.artists[1])!, (model.info?.artists[5])!, (model.info?.artists[6])!]
    lazy var after19 = model.info == nil ?[Artists.ArtistDetail]() :[(model.info?.artists[0])!, (model.info?.artists[2])!, (model.info?.artists[3])!, (model.info?.artists[4])!]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        tableView.estimatedRowHeight = 140
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Before 19th", "20th"]
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        search(forText: searchBar.text)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       search(forText: searchController.searchBar.text)
    }
    
    func search(forText queryText: String?) {
        searchedModel.removeAll()
        if let queryText = queryText?.lowercased(), let artists = model.info?.artists{
            if queryText.isEmpty{
                switch searchController.searchBar.selectedScopeButtonIndex{
                case 0:
                    searchedModel = artists
                case 1:
                    searchedModel = before19
                case 2:
                    searchedModel = after19
                default:
                    break
                }
                
            } else {
                var searchSource: [Artists.ArtistDetail]
                switch searchController.searchBar.selectedScopeButtonIndex{
                case 0:
                    searchSource = artists
                case 1:
                    searchSource = before19
                case 2:
                    searchSource = after19
                default:
                    searchSource = [Artists.ArtistDetail]()
                }
                for artist in searchSource{
                    if artist.name.lowercased().contains(queryText){
                        searchedModel.append(artist)
                    }
                }
            }
            tableView.reloadData()
        }
    }

    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive{
            return searchedModel.count
        } else {
            return model.info?.artists.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artist", for: indexPath)
        if let cell = cell as? ArtistTTableViewCell, let info = model.info{
            let artistInfo = searchController.isActive ?searchedModel[indexPath.row] :info.artists[indexPath.row]
            cell.artistName.text = artistInfo.name
            cell.artistBio.text = artistInfo.bio
            if let image = UIImage(named: artistInfo.image){
                cell.setImage(as: image)
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        searchController.isActive = false
        if let cell = sender as? ArtistTTableViewCell, let info = model.info, let paintVC = segue.destination as? PaintTableViewController{
            let artistName = cell.artistName.text
            for i in info.artists.indices{
                if artistName == info.artists[i].name{
                    paintVC.work = info.artists[i].works
                    break
                }
            }
        }
    }
    

}
