//
//  FinishedQuizViewController.swift
//  quiz_test
//
//  Created by Konada on 11/30/16.
//  Copyright © 2016 Konada. All rights reserved.
//

import UIKit

class FinishedQuizViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var scoreField: UILabel!

	
	
	@IBAction func resetScore(_ sender: AnyObject) {
		score = 0
		totalScore = 0
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scoreField.text = "\(Int(Double(score) / Double(totalScore) * 100)) %"
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
}
