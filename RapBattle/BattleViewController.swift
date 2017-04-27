//
//  BattleViewController.swift
//  RapBattle
//
//  Created by monus on 4/8/17.
//  Copyright © 2017 Deep S Randhawa. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, UITableViewDataSource {
    var rootBattle: Battle?
    var childAudios: [Audio] = []

    @IBOutlet weak var childRapsTableView: UITableView!
    //top battle:
    @IBOutlet weak var rootBattleProfileImage: UIImageView!
    
    @IBOutlet weak var rootUsername: UILabel!
    @IBOutlet weak var rootRemainingTime: UILabel!
    @IBAction func rootonPlayButton(_ sender: UIButton) {
    }

    @IBOutlet weak var rootSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childRapsTableView.dataSource = self
        // Do any additional setup after loading the view.
        rootUsername.text = rootBattle?.organizer?.getName()
        FirebaseClient.currentDB.bindSpecificBattle(rootBattle: rootBattle!) { (battle: NSDictionary) in
            if let fetchedAudios = battle["cyphers"] as? NSDictionary {
                var newArray = [Audio]()
                for (_, audio) in fetchedAudios {
                    let oneAudio = Audio(json: audio as! NSDictionary)
                    newArray.append(oneAudio)
                }
                newArray.remove(at: 0)
                self.childAudios = newArray
                self.childRapsTableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return childAudios.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = childRapsTableView.dequeueReusableCell(withIdentifier: "BattleTableViewCell") as! BattleTableViewCell
        
        cell.initializeWith(audio: childAudios[indexPath.row], rootBattle: rootBattle!)
        cell.isChild = true
        
        return cell
    }
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        childRapsTableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            if identifier == "ReplySegueInBVC" {
                let vc = segue.destination as! RecordViewController
                vc.battleRepliedTo = rootBattle!
                return
            }
        }
    }
 

}
