//
//  MainPageController.swift
//  Flags
//
//  Created by Oybek on 9/13/21.
//

import UIKit

class MainPageController: UIPageViewController, ViewInstaller {
    
    var quizzes = [
        Quiz(flagAnswer: .Andorra, flags: [.Andorra: UIImage(), .Andorra: UIImage()]),
        Quiz(flagAnswer: .Andorra, flags: [.Andorra: UIImage()]),
        Quiz(flagAnswer: .Andorra, flags: [.Andorra: UIImage()]),
    ]
    
    func setupSubviews() {
    }
    
    func setupConstraints() {
        
    }
    
    func setupTargets() {
        dataSource = self
    }
    
    func style() {
        
    }
    
    func localize() {
        
    }
    
    
}
extension MainPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let newQuizVC = QuizController()
        // get index from pageViewController
        newQuizVC.quiz = quizzes[0]
        return newQuizVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let newQuizVC = QuizController()
        // get index from pageViewController
        newQuizVC.quiz = quizzes[0]
        return newQuizVC
    }
    
}
