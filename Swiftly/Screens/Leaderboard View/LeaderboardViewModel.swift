//  INFO49635 - CAPSTONE FALL 2021
//  LeaderboardViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase

enum DownloadStatus {
    case success
    case failure
}

final class LeaderboardViewModel: ObservableObject {
    
    @Published var userLeaderboardData = [UserLeaderboardData]()
    @Published var isDataLoading: Bool = false
    
    var loggedInUser = User(firstName: "",
                            lastName: "",
                            username: "",
                            email: "",
                            password: "",
                            dob : "",
                            country: "",
                            classroom: [])
    
    func startDataRetrieval(){
        
        retrieveBasicUserData { downloadStatus, userDataArray in
            
            switch downloadStatus {
                
            case .success:
            
                var userData = userDataArray
                
                if userData.count > 1 {
                    for _ in 0..<userData.count {
                        for j in 1..<userData.count {
                            if userData[j].totalScore > userData[j-1].totalScore {
                                let tmp = userData[j-1]
                                userData[j-1] = userData[j]
                                userData[j] = tmp
                            }
                        }
                    }
                }
                
                self.userLeaderboardData = userData
                self.isDataLoading = false
                
            case .failure:
                self.isDataLoading = false
            }
        }
    }
   
    func retrieveBasicUserData(completion: @escaping(DownloadStatus, [UserLeaderboardData]) -> Void) {
        
        var downloadedUserData = [UserLeaderboardData]()
    
        let db = Firestore.firestore()
        
        db.collection("Students").getDocuments() { (querySnapshot, err) in
            if err != nil {
                completion(.failure, [])
            } else {
                
                var count = 0
                
                for document in querySnapshot!.documents {
                    
                    let username = document.data()["username"]! as! String
                    let country = document.data()["country"]! as! String
                    
                    self.downloadUserScoreData(documentId: document.documentID) { downloadStatus, testScore, totalScoreMax  in
                        
                        switch downloadStatus {
                            
                        case .success:
                            
                            let finalizedTestScore: Double = self.computeTotalScore(testScore: testScore,
                                                                                    totalScoreMax: totalScoreMax)
                            
                            let userData = UserLeaderboardData(username: username,
                                                               country: country,
                                                               totalScore: finalizedTestScore)
                            
                            downloadedUserData.append(userData)
                            
                            count += 1
                            
                            if count == querySnapshot!.documents.count {
                                count = 0
                                completion(.success, downloadedUserData)
                            }

                        case .failure:
                            completion(.failure, downloadedUserData)
                        }
                    }
                }
            }
        }
    }
    
    func downloadUserScoreData(documentId: String, completion: @escaping(DownloadStatus, Int, Int) -> Void) {
                    
        let db = Firestore.firestore()
        
        var testScore = 0, totalScoreMax = 0

        db.collection("Students").document(documentId).collection("Classrooms").document("classroom_1").collection("Chapters").getDocuments { (querySnapshot, err) in
            
            if err != nil{
                self.isDataLoading = false
                completion(.failure, testScore, totalScoreMax)
            } else {
                
                var count = 0
                
                for document in querySnapshot!.documents {
                    testScore += document.data()["total_question_score"]! as! Int
                    totalScoreMax += document.data()["total_questions"]! as! Int
                    
                    count += 1
                    
                    if count == querySnapshot!.documents.count {
                        count = 0
                        completion(.success, testScore, totalScoreMax)
                    }
                }
            }
        }
    }
    
    func computeTotalScore(testScore: Int, totalScoreMax: Int) -> Double {
        if totalScoreMax == 0 {
            return Double(0)
        } else {
            return (Double(testScore) / Double(totalScoreMax)) * 100
        }
    }
    
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
        case "Ireland":
            return "🇮🇪"
        case "Scotland":
            return "🏴󠁧󠁢󠁳󠁣󠁴󠁿"
        case "New Zealand":
            return "🇳🇿"
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
}
