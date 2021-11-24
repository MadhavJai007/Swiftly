//  INFO49635 - CAPSTONE FALL 2021
//  User.swift
//  Swiftly
//  Developers: Arjun Suthaharan, Madhav Jaisankar, Tobias Moktar

/// TODO: Needs achievements and other field variables from firestore

import Foundation
import SwiftUI

struct User: Hashable, Identifiable, Codable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var username: String
    var email: String
    var password: String
    var dob: String
    var country: String
    var classroom: [UserClassroom]
    
    /// Getting id
    func getId() -> UUID {
        return id
    }
    
    /// Getting first name
    func getFirstName() -> String {
        return firstName
    }
    
    /// Setting first name
    mutating func setFirstName(name: String){
        firstName = name
    }
    
    /// Getting last name
    func getLastName() -> String {
        return lastName
    }
    
    /// Setting last name
    mutating func setLastName(name: String){
        lastName = name
    }
    
    /// Getting username
    func getUsername() -> String {
        return username
    }
    
    /// Setting username
    mutating func setUsername(name: String){
        username = name
    }
    
    /// Getting email
    func getEmail() -> String {
        return email
    }
    
    /// Setting email
    mutating func setEmail(uEmail: String){
        email = uEmail
    }
    
    /// Getting password
    func getPassword() -> String {
        return password
    }
    
    /// Setting password
    mutating func setPassword(pass: String){
        password = pass
    }
    
    /// Getting dob
    func getDOB() -> String {
        return dob
    }
    
    /// Setting dob
    mutating func setDOB(birthdate: String){
        dob = birthdate
    }
    
    /// Getting country
    func getCountry() -> String {
        return country
    }
    
    /// Setting country
    mutating func setCountry(count: String){
        country = count
    }
    
    /// Getting classroom progress
    func getClassroomProgress() -> [UserClassroom] {
        return classroom
    }
    
    /// Setting classroom progress
    mutating func setClassroomProgress(classrm: [UserClassroom]){
        classroom = classrm
    }
    
}

struct UserClassroom: Hashable, Identifiable, Codable {
    var id = UUID()
    var classroomName = "placeholder"
    var subCode = ""
    var chapterProgress = [UserChapterProgress]()
    var clasroomTheoryStatus = "incomplete"
    var classroomPlaygroundStatus = "incomplete"
    var classroomStatus = "incomplete"
    
    /// Getting id
    func getId() -> UUID {
        return id
    }
    
    /// Getting classroom name
    func getClassroomName() -> String {
        return classroomName
    }
    
    /// Setting classroom name
    mutating func setClasroomName(name: String){
        classroomName = name
    }
    
    /// Getting sub code
    func getSubCode() -> String{
        return subCode
    }
    
    /// Setting sub code
    mutating func setSubCode(code: String){
        subCode = code
    }
    
    /// Getting chapter progress
    func getChapterProgres() -> [UserChapterProgress]{
        return chapterProgress
    }
    
    
    /// Setting chapter progress
    mutating func setChapterProgress(progress: [UserChapterProgress]) {
        chapterProgress = progress
    }
    
    /// Getting classroom theory status
    func getClassroomTheoryStatus() -> String{
        return clasroomTheoryStatus
    }
    
    /// Setting classroom theory status
    mutating func setClassroomTheoryStatus(status: String) {
        clasroomTheoryStatus = status
    }
    
    
    /// Getting classroom playground status
    func getClassroomPlaygroundStatus() -> String {
        return classroomPlaygroundStatus
    }
    
    /// Setting classroom playground status
    mutating func setClassroomPlaygroundStatus(status: String){
        classroomPlaygroundStatus = status
    }
    
    /// Getting classroom status
    func getClassroomStatus() -> String {
        return classroomStatus
    }
    
    /// Setting classroom status
    mutating func setClassroomStatus(status: String){
        classroomStatus = status
    }
}

struct UserChapterProgress: Hashable, Identifiable, Codable {
    var id = UUID()
    var chapterStatus: String
    var chapterName: String
    var chapterNum: Int
    var playgroundStatus: String
    var questionScores: [Int]
    var questionAnswers: [UserQuestionAnswer]
    var questionProgress: [String]
    var theoryStatus: String
    
    /// Getting id
    func getId() -> UUID {
        return id
    }
    
    /// Getting chapter status
    func getChapterStatus() -> String {
        return chapterStatus
    }
    
    /// Setting chapter status
    mutating func setChapterStatus(status: String) {
        chapterStatus = status
    }
    
    /// Getting chapter name
    func getChapterName() -> String {
        return chapterName
    }
    
    /// Setting chapter name
    mutating func setChapterName(name: String) {
        chapterName = name
    }
    
    /// Getting chapter num
    func getChapterNum() -> Int {
        return chapterNum
    }
    
    /// Setting chapter num
    mutating func setChapterNum(num: Int){
        chapterNum = num
    }
    
    /// Getting playground status
    func getPlaygroundStatus() -> String {
        return playgroundStatus
    }
    
    /// Setting playground status
    mutating func setPlaygroundStatus(status: String) {
        playgroundStatus = status
    }
    
    /// Getting question scores
    func getQuestionScores() -> [Int]{
        return questionScores
    }
    
    /// Setting question scores
    mutating func setQuestionScores(scores: [Int]){
        questionScores = scores
    }
    
    /// Getting question answers
    func getQuestionAnwers() -> [UserQuestionAnswer]{
        return questionAnswers
    }
    
    /// Setting question answers
    mutating func setQuestionAnswers(answers: [UserQuestionAnswer]){
        questionAnswers = answers
    }
    
    /// Getting question progress
    func getQuestionProgress() -> [String]{
        return questionProgress
    }
    
    /// Setting question progress
    mutating func setQuestionProgress(progress: [String]){
        questionProgress = progress
    }
    
    /// Getting theory status
    func getTheoryStatus() -> String{
        return theoryStatus
    }
    
    /// Setting theory status
    mutating func setTheoryStatus(status: String) {
        theoryStatus = status
    }

}

struct UserQuestionAnswer: Hashable, Identifiable, Codable {
    var id = UUID()
    var fId = ""
    var answers: [String]
    
    /// Getting ID
    func getId() -> UUID {
        return id
    }
    
    /// Getting firestore id
    func getFId() -> String {
        return fId
    }
    
    /// Setting firestore id
    mutating func setFId(id: String) {
        fId = id
    }
    
    /// Getting answers
    func getAnswers() -> [String]{
        return answers
    }
    
    /// Setting answers
    mutating func setAnswers(uAnswers: [String]){
        answers = uAnswers
    }
}
