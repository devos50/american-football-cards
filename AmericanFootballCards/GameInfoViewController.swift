//
//  GameInfoViewController.swift
//  AmericanFootballCards
//
//  Created by Martijn de Vos on 11-10-15.
//  Copyright © 2015 Martijn de Vos. All rights reserved.
//

import Foundation
import UIKit

/*
This class displays information about a specific game. It gets a dictionary with game info from the previous view controller (ScheduleTableViewController).
*/
class GameInfoViewController: UIViewController
{
    @IBOutlet weak var opponentImageView: UIImageView!
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var gameInfoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    
    var gameInfo: NSDictionary?
    var selectedTeam: NSDictionary?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Game Info"
        
        if gameInfo != nil
        {
            let date = gameInfo!["date"] as! NSDate
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            formatter.timeStyle = .ShortStyle
            dateLabel.text = "\(formatter.stringFromDate(date))"
            
            channelLabel.text = gameInfo!["network"] as? String
            stadiumLabel.text = gameInfo!["stadium"] as? String
            
            let opponentId = gameInfo!["opponent"] as! String
            teamImageView.image = UIImage(named: selectedTeam!["id"] as! String)!
            opponentImageView.image = UIImage(named: opponentId)!
            
            let opponentTeamInfo = TeamsManager.sharedInstance.getTeamInfoWithId(opponentId)
            gameInfoLabel.text = (selectedTeam!["name"] as! String) + " vs " + (opponentTeamInfo!["name"] as! String)
        }
        else
        {
            let alertController = UIAlertController(title: "Error", message: "An error has occurred when loading the game info.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Close", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}