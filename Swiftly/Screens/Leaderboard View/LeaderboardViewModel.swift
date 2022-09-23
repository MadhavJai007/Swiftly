//  INFO49635 - CAPSTONE FALL 2021
//  LeaderboardViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase

final class LeaderboardViewModel: ObservableObject {
    
    @Published var userLeaderboardData = [UserLeaderboardData]()
    @Published var isDataLoading: Bool = false
    
    var tempUserLeaderboard = [UserLeaderboardData]()
    
    let queue = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
    
    var loggedInUser = User(firstName: "",
                            lastName: "",
                            username: "",
                            email: "",
                            password: "",
                            dob : "",
                            country: "",
                            classroom: [])
    
    
    func startDataRetrieval(){
        retrieveBasicUserData {
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                if self.tempUserLeaderboard.count > 1 {
                    for i in 0..<self.tempUserLeaderboard.count {
                        for j in 1..<self.tempUserLeaderboard.count {
                            if self.tempUserLeaderboard[j].totalScore < self.tempUserLeaderboard[j-1].totalScore {
                                let tmp = self.tempUserLeaderboard[j-1]
                                self.tempUserLeaderboard[j-1] = self.tempUserLeaderboard[j]
                                self.tempUserLeaderboard[j] = tmp
                            }
                        }
                    }
                }
                
                self.userLeaderboardData = self.tempUserLeaderboard.reversed()
                self.isDataLoading = false
            })
        }
    }
   
    func retrieveBasicUserData(completion: @escaping() -> Void) {
        
        queue.async {
        
            let db = Firestore.firestore()
            
            db.collection("Students").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error: \(err)")
                } else {
                    
                    for document in querySnapshot!.documents {
                        
                        let username = document.data()["username"]! as! String
                        let country = document.data()["country"]! as! String
                        
                        self.downloadUserScoreData(documentId: document.documentID) { testScore, totalScoreMax in
                            let finalizedTestScore: Double = self.computeTotalScore(testScore: testScore, totalScoreMax: totalScoreMax)
                            let userData = UserLeaderboardData(username: username, country: country, totalScore: finalizedTestScore, progress: "NA")
                            self.tempUserLeaderboard.append(userData)
                        }
                    }
                }
            }
        
            Thread.sleep(forTimeInterval: 5)
            completion()
        }
    }
    
    func downloadUserScoreData(documentId: String, completion: @escaping(Int, Int) -> Void) {
        
        queue.async {
            
            let db = Firestore.firestore()
            
            var testScore = 0
            var totalScoreMax = 0

            db.collection("Students").document(documentId).collection("Classrooms").document("classroom_1").collection("Chapters").getDocuments { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting chapter documents: \(err)")
                    self.isDataLoading = false
                } else {
                    
                    for document in querySnapshot!.documents {
                        testScore += document.data()["total_question_score"]! as! Int
                        totalScoreMax += document.data()["total_questions"]! as! Int
                    }
                }
            }
            
            Thread.sleep(forTimeInterval: 5)
            completion(testScore, totalScoreMax)
        }
    }
    
    
    func computeTotalScore(testScore: Int, totalScoreMax: Int) -> Double {
        if totalScoreMax == 0 {
            return Double(0)
        } else {
            return (Double(testScore) / Double(totalScoreMax)) * 100
        }
    }
    
    //TODO: Toby find out what countries user can enter when signing up
    func getCountryFlag(country: String) -> String {
        
        switch country {
            
        case "Canada":
            return "🇨🇦"
        case "Australia":
            return "🇦🇺"
        case "United Kingdom":
            return "🇬🇧"
        case "United States":
            return "🇺🇸"
        default:
            return "🏴"
        }
    }
}

struct UserLeaderboardData {
    var id = UUID()
    var username: String
    var country: String
    var totalScore: Double
    var progress: String
}
