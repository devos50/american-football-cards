//
//  TeamsManager.swift
//  AmericanFootballCards
//
//  Created by Martijn de Vos on 11-10-15.
//  Copyright © 2015 Martijn de Vos. All rights reserved.
//

import Foundation

/*
The team manager singleton is responsible for parsing the teams data.
It loads the teams.plist file when being initialized the first time.
We can use this class to query the visible teams (on the first page) and to get more information about the team with a specific id.
*/
class TeamsManager
{
    static let sharedInstance = TeamsManager()
    var teamsDict: NSDictionary
    
    init()
    {
        let fileURL = NSBundle.mainBundle().pathForResource("teams", ofType: "plist")
        if let dict = NSDictionary(contentsOfFile: fileURL!) {
            self.teamsDict = dict
        } else {
            teamsDict = NSDictionary()
            print("Error while reading teams plist file.")
        }
    }
    
    func getVisibleTeams() -> NSArray
    {
        return teamsDict["visible"] as! NSArray
    }
    
    func getTeamInfoWithId(id: String) -> NSDictionary?
    {
        if let teamsInfo = teamsDict["teams"] as? NSArray {
            for teamInfo in teamsInfo {
                if (teamInfo["id"] as! String) == id {
                    return teamInfo as? NSDictionary
                }
            }
        }
        return nil
    }
}