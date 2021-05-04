//
//  UserListViewController.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/2/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import UIKit
import Firebase

class UserListViewController: UIViewController {

     // MARK: - Properties
    
    @IBOutlet weak var UserListLabel: UILabel!
    
    @IBOutlet weak var UsersTableView: UITableView!
    
    
  
    
    
    
  let ref = REF_USERS
    
 var userList = [UserList]()
    // MARK: - Lifecycale

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabelDataSetup()
        retrieveUsers()
    }
    
    // MARK: - Functions

    func tabelDataSetup()  {
        UsersTableView.delegate = self
        UsersTableView.dataSource = self
    }
    
    
    
    func retrieveUsers(){
        
        ref.observe(DataEventType.value, with:{(snapshot) in
            
            if(snapshot.childrenCount>0){
                self.userList.removeAll()
                
                for users in snapshot.children.allObjects as![DataSnapshot]{
                    let userObject = users.value as? [String:AnyObject]
                    let userfiestname = userObject?["firstname"]
                    let userlastname = userObject?["lastname"]

                    let uid = userObject?["uid"]
                    
                    let user = UserList(uid: uid as! String?, firstname: userfiestname as! String?, lastname: userlastname as! String?)
                    
                    self.userList.append(user)
                }
                
                self.UsersTableView.reloadData()
                
            }
        })
        
        }
    
    
    @IBAction func HandleBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)

    }
    
}


extension UserListViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("Tapped")
    }
}


extension UserListViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        var user:  UserList
        
        user = userList[indexPath.row]
        
        cell.textLabel?.text = user.firstName
        
        return cell
    }
}
