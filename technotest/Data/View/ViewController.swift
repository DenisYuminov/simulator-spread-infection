//
//  ViewController.swift
//  technotest
//
//  Created by macbook Denis on 5/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    // Dependencies
    private let output: DataViewOutput
    
    // UI
    private lazy var groupSizeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder  = "Введите размер группы"
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var factorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите фактор"
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var timeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите период"
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Запустить моделирование", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    // MARK: Init

    init(output: DataViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // Private
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        groupSizeTextField.placeholder = "Group Size"
        groupSizeTextField.font = UIFont.systemFont(ofSize: 18)
        groupSizeTextField.borderStyle = .roundedRect
        groupSizeTextField.autocapitalizationType = .none
        groupSizeTextField.keyboardType = .numberPad
        groupSizeTextField.delegate = self
        
        factorTextField.placeholder = "Factor"
        factorTextField.font = UIFont.systemFont(ofSize: 18)
        factorTextField.borderStyle = .roundedRect
        factorTextField.autocapitalizationType = .none
        factorTextField.keyboardType = .numberPad
        factorTextField.delegate = self
        
        timeTextField.placeholder = "Time Period"
        timeTextField.font = UIFont.systemFont(ofSize: 18)
        timeTextField.borderStyle = .roundedRect
        timeTextField.autocapitalizationType = .none
        timeTextField.keyboardType = .numberPad
        timeTextField.delegate = self
        
        startButton.setTitle("Start Simulation", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        startButton.backgroundColor = .systemBlue
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startSimulation), for: .touchUpInside)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubviews([
            groupSizeTextField,
            factorTextField,
            timeTextField,
            startButton
        ])
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            groupSizeTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            factorTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            timeTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            startButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.7)
        ])
    }
    
    // MARK: Actions
    @objc func startSimulation() {
        guard let size = Int(self.groupSizeTextField.text!) else { return }
        guard let factor = Int(self.factorTextField.text!) else { return }
        guard let period = Int(self.timeTextField.text!) else { return }
        
        output.startModeling(size: size, factor: factor, period: period)
    }
}
        
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: DataViewInput {
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
