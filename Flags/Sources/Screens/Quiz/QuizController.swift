//
//  QuizController.swift
//  Flags
//
//  Created by Oybek on 9/14/21.
//

import UIKit

class QuizController: ViewController {
    
    let _view = QuizView()
    var quiz: Quiz?
    
    override func loadView() {
        view = _view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    
    func setupTargets() {
        _view.quiz = quiz
    }
    
}
