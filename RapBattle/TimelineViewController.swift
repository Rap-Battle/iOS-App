//
//  TimelineViewController.swift
//  RapBattle
//
//  Created by Aditya Dhingra on 3/28/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TimelineViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var battlesTableView: UITableView!
    
    var battles: [Battle] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return battles.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = battlesTableView.dequeueReusableCell(withIdentifier: "BattleTableViewCell") as! BattleTableViewCell
       // let battle = battles[indexPath.row]
        
      //  cell.initializeWith(battle: battle)
        return cell
    }
    
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = battlesTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "BattleViewControllerSegue", sender: cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        battlesTableView.dataSource = self
        let titleImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 0,height: 15))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = UIImage(named: "RAPBATTLE")
        self.navigationItem.titleView = titleImageView
        
        // Get json of battles from firebase
        FirebaseClient.currentDB.bindTimelineWithTableView { (battles) in
            var fetchedBattles = [Battle]()
            for (_, v) in battles {
                // let oneBattle = Battle(json: v)
                // fetchedBattles.append(oneBattle)
            }
            self.battles = fetchedBattles
            self.battlesTableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let battleViewController = segue.destination as? BattleViewController {
            if let cell = sender as? BattleTableViewCell {
                battleViewController.battle = cell.battle
            }
        }
    }
 

}
