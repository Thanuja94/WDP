//
//  SharedService.swift
//  WDP
//
//  Created by Thanuja Nayanajith on 5/1/21.
//  Copyright © 2021 NIBM. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseDatabase


let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_DISEASE = DB_REF.child("diseases")



struct Service {
    
    static var shared = Service()
    
    var currentUserID = Auth.auth().currentUser?.uid ;

    
    
    func fetchUserData(uid: String, completion: @escaping(User) -> Void) {
          REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
              guard let dictionary = snapshot.value as? [String: Any] else { return }
              let uid = snapshot.key
              let user = User(uid: uid, dictionary: dictionary)
             
              completion(user)
          }
      }
    
    
    func fetchDiseaseData(diseaseName: String, completion: @escaping(Disease) -> Void) {
        REF_DISEASE.child(diseaseName).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let diseaseName = snapshot.key
            let disease = Disease(diseaseName: diseaseName, dictionary: dictionary)

            completion(disease)
       }
   }
}
