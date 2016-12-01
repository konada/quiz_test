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
	@IBOutlet var quizProgress: UIProgressView!
	
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
	var answerList: NSArray = []
	var answerCount: Int = 0
	var totalQuestionsCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
			
			session = URLSession.shared
			task = URLSessionDownloadTask()
			
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
	
		
		for i in 0...answerCount - 1 {
			buttons[i].setTitle(answers[qNumber - 1][i], for: UIControlState())
		}
		
		for i in 0...buttons.count - 1 {
			if buttons[i].titleLabel?.text == nil {
				print("yes")
				buttons[i].isHidden = true
			}
		}
		
		answerNumber = correctAnswers[qNumber - 1]
		
		print(answerNumber)
		
		questions.remove(at: qNumber - 1)
		
		setProgress()
	}
	else{
		NSLog("Done!")
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
			
			task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
				
				if location != nil{
					let data:Data! = try? Data(contentsOf: location!)
					do{
						let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! NSDictionary
						self.quizData = dic["questions"] as! [NSDictionary]!
						DispatchQueue.main.async(execute: { () -> Void in
							
							for index in 0...(self.quizData.count - 1) {
								let dictionary = self.quizData[index] as! [String : AnyObject]
								self.questions.append(dictionary["text"] as! String)
								
								self.answerList = (dictionary["answers"] as! NSArray)
								self.answerCount = self.answerList.count
								
								for index in 0...(self.answerCount - 1) {
									let answers = (self.answerList[index] as? NSDictionary)?["text"] as? String
									let correctAnswers = ((self.answerList)[index] as? NSDictionary)?["isCorrect"] as? Bool
									self.answersTest.append(answers!)
									self.correctAnswerTest.append(correctAnswers ?? false)
								}
								
								self.correctAnswers = stride(from: 0, to: self.correctAnswerTest.count, by: self.answerCount).map {
									let end = self.correctAnswerTest.endIndex
									let chunkEnd = self.correctAnswerTest.index($0, offsetBy: self.answerCount, limitedBy: end) ?? end
									return Array(self.correctAnswerTest[$0..<chunkEnd])
								}
								
								self.answers = stride(from: 0, to: self.answersTest.count, by: self.answerCount).map {
									let end = self.answersTest.endIndex
									let chunkEnd = self.answersTest.index($0, offsetBy: self.answerCount, limitedBy: end) ?? end
									return Array(self.answersTest[$0..<chunkEnd])
								}
								
							}
							self.totalQuestionsCount = self.questions.count
							self.pickQuestion()
						})
					}catch{
						print("something went wrong, try again")
					}
				}
			})
			task.resume()
	}
	
	func setProgress(){
		
		quizProgress.setProgress((Float(totalScore) / Float(totalQuestionsCount)), animated: true )
	}
	
	}






