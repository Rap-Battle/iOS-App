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
    var childBattles: [Battle] = []

    @IBOutlet weak var childRapsTableView: UITableView!
    //top battle:
    @IBOutlet weak var rootBattleProfileImage: UIImageView!
    
    @IBOutlet weak var rootUsername: UILabel!
    @IBOutlet weak var rootRemainingTime: UILabel!
    @IBAction func rootonPlayButton(_ sender: UIButton) {
    }
    @IBAction func onBattleButton(_ sender: UIButton) {
    }
    @IBOutlet weak var rootSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childRapsTableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return childBattles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = childRapsTableView.dequeueReusableCell(withIdentifier: "BattleTableViewCell") as! BattleTableViewCell
        
        cell.initializeWith(battle: childBattles[indexPath.row])
        cell.isChild = true
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
