//
//  QuizView.swift
//  Flags
//
//  Created by Oybek on 9/14/21.
//

import UIKit

class QuizView: View {
    var quiz: Quiz!
    private lazy var questionLabel: UILabel = {
        let label = NYLabel(textColor: .white, textAlignment: .center, numberOfLines: 0)
        let attributedString = NSMutableAttributedString(string: "Which one is\n", attributes: [.font: UIFont.systemFont(ofSize: 18)])
        attributedString.append(NSAttributedString(string: "\(quiz.flagAnswer) ?", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]))
        label.attributedText = attributedString
        return label
    }()
    private lazy var option0 = createOption(index: 0)
    private lazy var option1 = createOption(index: 1)
    private lazy var option2 = createOption(index: 2)
    private lazy var option3 = createOption(index: 3)
    private lazy var stack1: UIStackView = {
        let stack = NYStackView(axis: .horizontal, distribution: .fillEqually, spacing: 8)
        stack.addArrangedSubview(option0)
        stack.addArrangedSubview(option1)
        return stack
    }()
    private lazy var stack2: UIStackView = {
        let stack = NYStackView(axis: .horizontal, distribution: .fillEqually, spacing: 8)
        stack.addArrangedSubview(option2)
        stack.addArrangedSubview(option3)
        return stack
    }()
    
    private func createOption(index: Int) -> UIImageView {
        let dictIndex = quiz.flags.index(quiz.flags.startIndex, offsetBy: index)
        let imageView = NYImageView(image: quiz.flags.values[dictIndex], cornerRadius: 5, contentMode: .scaleAspectFit)
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = Color.mainLightColor.cgColor
        return imageView
    }
    
    override func style() {
        super.style()
        contentView.backgroundColor = Color.mainDarkColor
    }
    override func setupTargets() {
        super.setupTargets()
    }
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(questionLabel)
        contentView.addSubview(stack1)
        contentView.addSubview(stack2)
    }
    override func setupConstraints() {
        super.setupConstraints()
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            stack1.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            stack1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stack1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            stack2.topAnchor.constraint(equalTo: stack1.bottomAnchor, constant: 24),
            stack2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stack2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
}
