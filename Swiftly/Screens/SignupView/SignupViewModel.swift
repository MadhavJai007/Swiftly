//  INFO49635 - CAPSTONE FALL 2021
//  SignupViewModel.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

final class SignupViewModel: ObservableObject {
    
    
    init(){
        //initializer
    }
    
    
    @Published var newUser = User(firstName: "",
                                  lastName: "",
                                  username: "",
                                  email: "",
                                  password: "",
                                  dob : "",
                                  country: "Canada",
                                  classroom: [UserClassroom()])
    
    //boolean to check if email exists in database
    @Published var isBadSignup: Bool = false
    
    //boolean to ensure that email being used has not already been registered with Swiftly
    @Published var emailNotTaken: Bool = false
    
    //variable used for alert notification
    @Published var alertInfo: AlertModel?
    
    
    //db variable for firestore information
    private var db = Firestore.firestore()
    
    
    //array for storing chapter information
    @Published var chaptersArr = [Chapter]()
    
    
    let listOfBadWords = ["crap", "fuck", "shit", "ass", "penis", "dick","cunt", "whore", "vagina", "boobs", "tits", "fucker", "slut", "motherfucker", "cock", "dildo", "bitch"]
    
    
    
    //Validation functions
    
    func isEmailValid() -> Bool{
        
        ///email input must be in email@email.com format
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return emailTest.evaluate(with: newUser.email)
    }
    
    
    func isDateValid() -> Bool{
        
        ///date of birth input must be in dd/mm/yyyy format, only numerics
        
        let dateTest = NSPredicate(format: "SELF MATCHES %@", "^\\d{2}\\/\\d{2}\\/\\d{4}$")
        return dateTest.evaluate(with: newUser.dob)
    }
    
    
    func isPasswordValid() -> Bool{
        
        ///password input must be at least 8 characters, no more than 15 characters, and must include at least one upper case letter, one lower case letter, and one numeric digit
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=[^\\d_].*?\\d)\\w(\\w|[!@#$%]){7,20}")
        return passwordTest.evaluate(with: newUser.password)
    }
    
    func isUserNameValid() -> Bool{
        
        ///username input must be at least 5 characters, no more than 20 characters, start with a letter, and cannot contain a _ or . without a letter in front of it
        
        let userNameTest = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z](_(?!(\\.|_))|\\.(?!(_|\\.))|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$")
        return userNameTest.evaluate(with: newUser.username)
    }
    
    func isFirstNameValid() -> Bool{
        return newUser.firstName != ""
    }
    
    func isLastNameValid() -> Bool{
        return newUser.lastName != ""
    }
    
    func isCountryValid() -> Bool{
        return newUser.country != ""
    }
    
    ///Boolean variable that determines if user credentials are valid, based on previous validation functions
    var isSignUpComplete : Bool {
        if !isEmailValid(){
            return false
        }
        
        if !isPasswordValid(){
            return false
        }
        
        if !isDateValid(){
            return false
        }
        if !isUserNameValid(){
            return false
        }
        if !isFirstNameValid(){
            return false
        }
        if !isLastNameValid(){
            return false
        }
        if !isCountryValid(){
            return false
        }
        return true
    }
    
    func validateUsername(username: String) -> Bool {
        return listOfBadWords.reduce(false) { $0 || username.contains($1.lowercased()) }
    }
    
    ///function to check if email already exists in Swiftly database
    func checkIfEmailExists(user: User){
        print("Email to be checked if it exists in Users collection is : \(user.email)")
        
        let emailCompared = user.email
        
        //        print("After lowercased its : \(emailCompared)")
        //
        //        switch accountType {
        //        case "Student":
        //            print("search student collection")
        //            let collectionRef = db.collection("Students")
        //
        //        case "Teacher":
        //            print("search teacher collection")
        //            let collectionRef = db.collection("Teachers")
        //        default:
        //            print("there is no default case")
        //
        //        }
        /// retrieving  Firebase collection
        let collectionRef = db.collection("Students")
        
        /// getting all the documents where the field username is equal to the String you pass, loop over all the documents.
        
        collectionRef.whereField("email", isEqualTo: emailCompared).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else if (snapshot?.isEmpty)! {
                print("Email is not taken. It is valid.")
                self.emailNotTaken = true
            } else {
                for document in (snapshot?.documents)! {
                    if document.data()["username"] != nil {
                        print("Email is Taken. It is NOT valid.")
                        self.emailNotTaken = false
                        
                    }
                }
            }
        }
        
    }
    
    func checkIfEmailExistsCompletion(user: User, completion: () -> Void){
        print("check for students")
    }
    
    ///fucntion for adding user data to authentication database and Students/Teachers and Users firestore collections
    func authenticateUser(user: User){
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [self] user, error in
            print("Created authentication account successfully")
        }
    }
    
    func addUser(user: User, accountType: String){
        
        print("is \(accountType)")
        
        ///switch case for creating a new "Student' or "Teacher' account
        switch accountType {
            
            ///Student case
        case "Student":
            
            var newStudentRef = db.collection("Students").document(user.username)
            
            ///setting all user information based on user input for signupview
            newStudentRef.setData([
                "country": user.country,
                "date_of_birth": user.dob,
                "email": user.email,
                "firstname" : user.firstName,
                "username" : user.username,
                "lastName" : user.lastName,
                //"password" : user.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Student successfully added!")
                }
            }
            
            
            newStudentRef = newStudentRef.collection("Classrooms").document("classroom_1")
            newStudentRef.setData(["instructor_id" : "placeholder"])
            
            ///creating collection for user classrooms, which will contain users progress, answers and scores for each chapter
            for i in 0..<chaptersArr.count{

                /// only for testing purposes
                if (chaptersArr[i].chapterNum > 0){
                    
                    let playgroundArray = chaptersArr[i].playgroundArr
                    
                    newStudentRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)").setData([
                        "chapters_num" : chaptersArr[i].chapterNum,
                        "chapters_name" : chaptersArr[i].name,
                        "playground_status" : "incomplete",
                        "chapter_status" : "incomplete",
                        "theory_status" : "incomplete",
                        "total_question_score": 0,
                        "total_questions": playgroundArray.count])
                    
                    var questionsArray : [Int] = []
                    var playgroundAnswers : [String] = []
                    var playgroundProgress : [String] = []
                    var questionsId: [String] = []
                    
                    var document = newStudentRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)")
                    
                    for j in 0..<playgroundArray.count {
                        questionsId.append(playgroundArray[j].fId)
                        questionsArray.append(0)
                        playgroundProgress.append("incomplete")
                        document.updateData(["question_\(j+1)_answer" : playgroundAnswers])
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    
                        document.updateData(["question_scores" : questionsArray,
                                             "question_progress" : playgroundProgress,
                                             "question_ids":questionsId])
                        
                    }
                }
                    
                
            }
            
            ///teacher case
        case "Teacher":
            
            var newTeacherRef = db.collection("Teachers").document(user.username)
            
            newTeacherRef.setData([
                "country": user.country,
                "date_of_birth": user.dob,
                "email": user.email,
                "firstname" : user.firstName,
                "lastName" : user.lastName,
                "username" : user.username,
                //"password" : user.password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Teacher successfully added!")
                }
            }
            
            newTeacherRef = newTeacherRef.collection("Classrooms").document("classroom_1")
            newTeacherRef.setData(["instructor_id" : "placeholder"])
            
            for i in  0...chaptersArr.count-1{
                var playgroundArray = chaptersArr[i].playgroundArr
                
                newTeacherRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)").setData(["chapters_num" : chaptersArr[i].chapterNum,"chapters_name" : chaptersArr[i].name, "playground_status" : "incomplete", "chapter_status" : "incomplete", "theory_status" : "incomplete"])
                
                var questionsArray : [Int] = []
                
                for j in 0...playgroundArray.count-1{
                    questionsArray.append(0)
                    
                }
                var document = newTeacherRef.collection("Chapters").document("chapter_\(chaptersArr[i].chapterNum)")
                document.updateData(["question_scores" : questionsArray])
            }
            
            
            
        default:
            print("Error in determining between Teacher and Student account type")
        }
        
        // adding user to the "Users" collection in database
        /*
        db.collection("Users").document(user.username).setData([
            "user_email": user.email,
            "user_type": accountType
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("User successfully added!")
            }
        }
         */
        
        
    }
    
     
    func save(accountType: String){
        
        //checking if connected to internet
        
        print("email: \(newUser.email)");
        print("password: \(newUser.password)")
        print("account type: \(accountType)")
        
        checkIfEmailExistsCompletion(user: newUser, completion:{
            print("now check for teachers")
        })
        
        
        emailNotTaken = false
        
        print("First we will check if the email already exists in our database using checkIfEmailExists().")
        checkIfEmailExists(user: newUser)
        
        
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [self] (timer) in
            
            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == false){
                self.isBadSignup = true
            }
            
        }
        
        let timer2 = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: false) { [self] (timer) in
            
            print("The email is not taken is : \(emailNotTaken)")
            if(emailNotTaken == true){
                print("Since the email was valid, now execute authenticateUser() to add user to authenticator")
                self.authenticateUser(user: newUser)
            }
        }
        
        let timer3 = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { [self] (timer) in
            if(emailNotTaken == true){
                print("Finally, since the email was valid, now execute addUser() to add user to collections")
                self.addUser(user: newUser, accountType: accountType)
            }
            
        }
        
    }
    
    
}
