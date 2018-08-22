//
//  PaintTableViewController.swift
//  Project 04 Art
//
//  Created by Chris on 21/8/2018.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class PaintTableViewController: UITableViewController, ButtonClick {

    var work: [Artists.ArtistDetail.Work]?
    var expandedSections = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return work?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "painting", for: indexPath)
        if let cell = cell as? PaintingTableViewCell, let work = work{
            cell.section = indexPath.section
            cell.buttonClick = self
            cell.paintName.text = work[indexPath.section].title
            cell.paintDetail.text = work[indexPath.section].info
            cell.paintImage.image = UIImage(named: work[indexPath.section].image)
            
            if expandedSections.contains(indexPath.section){
                cell.paintDetail.isHidden = false
                cell.button.setTitle("less info", for: .normal)
            } else {
                cell.paintDetail.isHidden = true
                cell.button.setTitle("more info >", for: .normal)
            }
        }

        return cell
    }
    
    func click(atSection section: Int) {
        if expandedSections.contains(section){
            expandedSections.remove(at: expandedSections.index(of: section)!)
        } else {
            expandedSections.append(section)
        }
        tableView.reloadRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
    }

 }


