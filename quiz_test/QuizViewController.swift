//
//  QuizViewController.swift
//  quiz_test
//
//  Created by Konada on 11/29/16.
//  Copyright © 2016 Konada. All rights reserved.
//

import UIKit

var score: Int = 0
var totalScore: Int = 0

class QuizViewController: UIViewController {
	
	@IBOutlet var questionLabel: UILabel!
	@IBOutlet var buttons: [UIButton]!
	
	var task: URLSessionDownloadTask!
	var session: URLSession!
	
	var quizData: [NSDictionary] = []
	var qNumber = Int()
	var answerNumber = [Bool]()
	var questions: [String] = []
	var answersTest = [String]()
	var correctAnswerTest = [Bool]()
	var answers : [[String]]!
	var correctAnswers : [[Bool]]!


    override func viewDidLoad() {
        super.viewDidLoad()
			
			session = URLSession.shared
			task = URLSessionDownloadTask()
			
			questions = []
			
			createQuestions()
			
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


func pickQuestion(){
	
	if questions.count > 0 {
		
		qNumber = Int(questions.count)
		
		print(questions[qNumber - 1])
		
		questionLabel.text = "\(questions[qNumber - 1])"
	
		
		for i in 0..<buttons.count {
			buttons[i].setTitle(answers[qNumber - 1][i], for: UIControlState())
		}
		
		answerNumber = correctAnswers[qNumber - 1]
		
		print(answerNumber)
		
		questions.remove(at: qNumber - 1)
	}
	else{
		NSLog("Done!")
		let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FinishedQuizViewController") as! FinishedQuizViewController
		//secondViewController.scoreField.text! = "\(score)"
		performSegue(withIdentifier: "QuizFinished", sender: self)
		print(score)
		print(totalScore)
	}


}

	@IBAction func button1Tap(_ sender: AnyObject) {
		if answerNumber[0] == true {
			score += 1
			totalScore += 1
			pickQuestion()
		}
		else {
			NSLog("Wrong Answer!")
			totalScore += 1
			pickQuestion()
		}
	}
	@IBAction func button2Tap(_ sender: AnyObject) {
		if answerNumber[1] == true {
			score += 1
			totalScore += 1
			pickQuestion()
		}
		else {
			NSLog("Wrong Answer!")
			totalScore += 1
			pickQuestion()
		}
	}
	@IBAction func button3Tap(_ sender: AnyObject) {
		if answerNumber[2] == true {
			score += 1
			totalScore += 1
			pickQuestion()
		}
		else {
			NSLog("Wrong Answer!")
			totalScore += 1
			pickQuestion()
		}
	}
	@IBAction func button4Tap(_ sender: AnyObject) {
		if answerNumber[3] == true {
			score += 1
			totalScore += 1
			pickQuestion()
		}
		else {
			NSLog("Wrong Answer!")
			totalScore += 1
			pickQuestion()
		}
	}
	
		func createQuestions(){
			let url:URL! = URL(string: "http://quiz.o2.pl/api/v1/quiz/"+quizLink+"/0")
			print(url)
			task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
				
				if location != nil{
					let data:Data! = try? Data(contentsOf: location!)
					do{
						let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
						self.quizData = dic["questions"] as! [NSDictionary]!
						DispatchQueue.main.async(execute: { () -> Void in
							for index in 0...self.quizData.count-1 {
								let dictionary = self.quizData[index] as! [String : AnyObject]
								self.questions.append(dictionary["text"] as! String)
								for index in 0...3 {
									let answers = ((dictionary["answers"] as! NSArray)[index] as? NSDictionary)?["text"] as? String
									let correctAnswers = ((dictionary["answers"] as! NSArray)[index] as? NSDictionary)?["isCorrect"] as? Bool
									self.answersTest.append(answers!)
									self.correctAnswerTest.append(correctAnswers ?? false)
								}
							}
							self.correctAnswers = stride(from: 0, to: self.correctAnswerTest.count, by: 4).map {
								let end = self.correctAnswerTest.endIndex
								let chunkEnd = self.correctAnswerTest.index($0, offsetBy: 4, limitedBy: end) ?? end
								return Array(self.correctAnswerTest[$0..<chunkEnd])
							}
							self.answers = stride(from: 0, to: self.answersTest.count, by: 4).map {
								let end = self.answersTest.endIndex
								let chunkEnd = self.answersTest.index($0, offsetBy: 4, limitedBy: end) ?? end
								return Array(self.answersTest[$0..<chunkEnd])
							}
							self.pickQuestion()
						})
					}catch{
						print("something went wrong, try again")
					}
				}
			})
			task.resume()
	}
	}
			



	

