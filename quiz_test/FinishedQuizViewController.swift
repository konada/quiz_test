//
//  FinishedQuizViewController.swift
//  quiz_test
//
//  Created by Konada on 11/30/16.
//  Copyright © 2016 Konada. All rights reserved.
//

import UIKit
import CoreData

class FinishedQuizViewController: UIViewController, UITextFieldDelegate {

	
	@IBOutlet weak var scoreField: UILabel!

	@IBAction func resetScore(_ sender: AnyObject) {
		score = 0
		totalScore = 0
	}
	
//	let managedObjectContext = (UIApplication.shared.delegate 
//  as! AppDelegate).managedObjectContext

	
	override func viewDidLoad() {
		super.viewDidLoad()

		scoreField.text = "\(Int(Double(score) / Double(totalScore) * 100)) %"
		
		//		let entityDescription =
		//			NSEntityDescription.entity(forEntityName: "Quizes",
		//			                           in: managedObjectContext)
		//
		//		let quiz = Quizes(entity: entityDescription!,
		//		                       insertInto: managedObjectContext)
		//
		//		quiz.quizNum = quizLink
		//		quiz.score = scoreField.text!
		//
		//		do {
		//			try managedObjectContext.save()
		//
		//			scoreField.text = ""
		//
		//		} catch let error {
		//			print(error.localizedDescription)
		//		}
		
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}
