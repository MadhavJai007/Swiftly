//  INFO49635 - CAPSTONE FALL 2022
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

enum UploadStatus {
    case success
    case failure
}

final class LeaderboardViewModel: ObservableObject {
    
    @Published var userLeaderboardData = [UserLeaderboardData]()
    @Published var isDataLoading: Bool = false
    @Published var chapterFilters = [""]
    
    var countryFilters = ["None", "đ¨đŚ", "đŚđş", "đŹđ§", "đşđ¸", "đŽđŞ", "đ´ó §ó ˘ó łó Łó ´ó ż", "đłđż"]
    
    var selectedCountryFilter = "None"
    var selectedFilter = "None"
    
    var loggedInUser = User(firstName: "",
                            lastName: "",
                            username: "",
                            email: "",
                            password: "",
                            dob : "",
                            country: "",
                            classroom: [])
    
    func startDataRetrieval(filterOne: String? = nil, filterTwo: String? = nil){
        
        userLeaderboardData.removeAll()
        
        let countryFilter = getCountryStringFromFlag(country: filterTwo ?? "")
        
        retrieveBasicUserData(filterOne: filterOne, filterTwo: countryFilter) { downloadStatus, userDataArray in
            
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
   
    func retrieveBasicUserData(filterOne: String? = nil,
                               filterTwo: String? = nil,
                               completion: @escaping(DownloadStatus, [UserLeaderboardData]) -> Void) {
        
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
                     
                    self.downloadUserScoreData(filterOne: filterOne,
                                               documentId: document.documentID) { downloadStatus, testScore, totalScoreMax  in
                        
                        switch downloadStatus {
                            
                        case .success:
                            
                            let finalizedTestScore: Double = self.computeTotalScore(testScore: testScore,
                                                                                    totalScoreMax: totalScoreMax)
                            
                            let userData = UserLeaderboardData(username: username,
                                                               country: country,
                                                               totalScore: finalizedTestScore)
                            
                            if filterTwo != "None" {
                                if filterTwo == country {
                                    if finalizedTestScore != 0.0 || username == self.loggedInUser.username {
                                        downloadedUserData.append(userData)
                                    }
                                }
                            } else {
                                if finalizedTestScore != 0.0 || username == self.loggedInUser.username {
                                    downloadedUserData.append(userData)
                                }
                            }
                            
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
    
    func downloadUserScoreData(filterOne: String? = nil,
                               documentId: String,
                               completion: @escaping(DownloadStatus, Int, Int) -> Void) {
        
        let db = Firestore.firestore()
        
        var testScore = 0, totalScoreMax = 0
        
        db.collection("Students").document(documentId).collection("Classrooms").document("classroom_1").collection("Chapters").getDocuments { (querySnapshot, err) in
            
            if err != nil{
                self.isDataLoading = false
                completion(.failure, testScore, totalScoreMax)
            } else {
                
                var count = 0
                
                for document in querySnapshot!.documents {
                    
                    let totalQuestionScore = (document.data()["total_question_score"] as? Int) ?? 0
                    let totalQuestions = (document.data()["total_questions"] as? Int) ?? 0
                    
                    if filterOne == nil {
                        testScore += totalQuestionScore
                        totalScoreMax += totalQuestions
                        
                    } else {
                        if filterOne == "Chapter \(count+1)" {
                            testScore += totalQuestionScore
                            totalScoreMax += totalQuestions
                        }
                    }
                    
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
    
    func getCountryStringFromFlag(country: String) -> String {
        switch country {
        case "đ¨đŚ":
            return "Canada"
        case "đŚđş":
            return "Australia"
        case "đŹđ§":
            return "United Kingdom"
        case "đşđ¸":
            return "United States"
        case "đŽđŞ":
            return "Ireland"
        case "đ´ó §ó ˘ó łó Łó ´ó ż":
            return "Scotland"
        case "đłđż":
            return "New Zealand"
        default:
            return "None"
        }
    }
    
    func getCountryFlag(country: String) -> String {
        
        switch country {
        case "Canada":
            return "đ¨đŚ"
        case "Australia":
            return "đŚđş"
        case "United Kingdom":
            return "đŹđ§"
        case "United States":
            return "đşđ¸"
        case "Ireland":
            return "đŽđŞ"
        case "Scotland":
            return "đ´ó §ó ˘ó łó Łó ´ó ż"
        case "New Zealand":
            return "đłđż"
        default:
            return "đ´"
        }
    }
}

struct UserLeaderboardData {
    var id = UUID()
    var username: String
    var country: String
    var totalScore: Double
}
