//
//  ScheduleTableViewController.swift
//  AmericanFootballCards
//
//  Created by Martijn de Vos on 08-10-15.
//  Copyright © 2015 Martijn de Vos. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
}

/*
The schedule table view controller displays the upcoming games for a specific selected team on the first page. The information about the selected team are passed to this view controller and used to fetch the schedule in the viewDidLoad method.
*/
class ScheduleTableViewController: UITableViewController
{
    var schedule = []
    var selectedTeam: NSDictionary?
    var selectedIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if selectedTeam != nil {
            self.title = selectedTeam!["name"] as? String
            schedule = selectedTeam!["schedule"] as! NSArray
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "GameInfoSegue"
        {
            if let vc = segue.destinationViewController as? GameInfoViewController
            {
                vc.gameInfo = schedule[selectedIndex] as? NSDictionary
                vc.selectedTeam = selectedTeam
            }
        }
    }
}

extension ScheduleTableViewController
{
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return schedule.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : ScheduleCell? = tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell
        if(cell == nil)
        {
            cell = ScheduleCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ScheduleCell")
        }
        
        if let opponentTeamInfo = TeamsManager.sharedInstance.getTeamInfoWithId(schedule[indexPath.row]["opponent"] as! String) {
            if let img = UIImage(named: opponentTeamInfo["id"] as! String) {
                cell?.teamImageView.image = img
            }
            
            cell?.mainLabel.text = (opponentTeamInfo["name"] as! String)
            let date = schedule[indexPath.row]["date"] as! NSDate
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            formatter.timeStyle = .ShortStyle
            cell?.detailLabel.text = "\(formatter.stringFromDate(date))"
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
        self.performSegueWithIdentifier("GameInfoSegue", sender: self)
    }
}