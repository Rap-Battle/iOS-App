//
//  TimelineViewController.swift
//  RapBattle
//
//  Created by Aditya Dhingra on 3/28/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


protocol BattleToRecordDelegate {
    func toRecord(battle: Battle)
}

class TimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, BattleToRecordDelegate {
    func toRecord(battle: Battle) {
        performSegue(withIdentifier: "ReplySegue", sender: battle)
    }

    @IBOutlet weak var battlesTableView: UITableView!
    
    var battles: [Battle] = []
    // MARK: - Table View
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return battles.count
    }
    @IBAction func didTapLougout(_ sender: UIBarButtonItem) {
        try! FIRAuth.auth()!.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = battlesTableView.dequeueReusableCell(withIdentifier: "BattleTableViewCell") as! BattleTableViewCell
        cell.initializeWith(battle: battles[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = battlesTableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "BattleViewControllerSegue", sender: cell)
        battlesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        battlesTableView.dataSource = self
        battlesTableView.delegate = self
        let titleImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 0,height: 20))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.image = UIImage(named: "logo")
        self.navigationItem.titleView = titleImageView
        
        // Get json of battles from firebase
        FirebaseClient.currentDB.bindTimelineWithTableView { (battles) in
            var fetchedBattles = [Battle]()
            for (_, v) in battles {
                let oneBattle = Battle(json: v as! NSDictionary)
                fetchedBattles.append(oneBattle)
            }
            self.battles = fetchedBattles
            self.battlesTableView.reloadData()
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "ReplySegue" {
                let vc = segue.destination as! RecordViewController
                vc.battleRepliedTo = sender as! Battle
                return
            }
        }
        if let battleViewController = segue.destination as? BattleViewController {
            if let cell = sender as? BattleTableViewCell {
                battleViewController.rootBattle = cell.battle
            }
        }
    }
 

}
