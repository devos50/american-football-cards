//
//  TeamsTableViewController.swift
//  AmericanFootballCards
//
//  Created by Martijn de Vos on 08-10-15.
//  Copyright © 2015 Martijn de Vos. All rights reserved.
//

import Foundation
import UIKit

class TeamCell: UITableViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
}

/*
The teams table view controller displays the teams in the first page.
The teams are fetched from the TeamsManager class and this is done in the viewDidLoad method.
*/
class TeamsTableViewController: UITableViewController
{
    var teams = []
    var selectedIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        teams = TeamsManager.sharedInstance.getVisibleTeams()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ScheduleSegue"
        {
            if let vc = segue.destinationViewController as? ScheduleTableViewController
            {
                vc.selectedTeam = TeamsManager.sharedInstance.getTeamInfoWithId(teams[selectedIndex] as! String)
            }
        }
    }
}

extension TeamsTableViewController
{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return teams.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : TeamCell? = tableView.dequeueReusableCellWithIdentifier("TeamCell") as? TeamCell
        if(cell == nil)
        {
            cell = TeamCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TeamCell")
        }
        
        if let teamInfo = TeamsManager.sharedInstance.getTeamInfoWithId(teams[indexPath.row] as! String)
        {
            if let img = UIImage(named: teamInfo["id"] as! String)
            {
                cell?.teamImageView.image = img
            }
            
            cell?.teamLabel.text = teamInfo["name"] as? String
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedIndex = indexPath.row
        self.performSegueWithIdentifier("ScheduleSegue", sender: self)
    }
}