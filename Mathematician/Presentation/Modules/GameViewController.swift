//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var exampleTextField: UITextField!
    @IBOutlet weak var userInputLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightAnswerImageView: UIImageView!
    @IBOutlet weak var wrongAnswerImageView: UIImageView!

    private let buttonsLabels: [String] = ["1", "2", "3", "OK", "4", "5", "6", "C", "7", "8", "9", "<-", "-", "0", "."]
    private var firstValue: Int = 0
    private var secondValue: Int = 0
    private var action: Character = "+"

    private var dependencies = Services
    lazy var programSettings = dependencies.settingsService.programSettings

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: NSStringFromClass(CollectionViewCell.self))
        collectionView.register(CollectionViewSettingssCell.self,
                                forCellWithReuseIdentifier: NSStringFromClass(CollectionViewSettingssCell.self))
        getNewExample()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dependencies.settingsService.programSettings = programSettings
    }

    private func getNewExample() {
        repeat {
            generateValues()
        } while !checkValues()
        exampleTextField.text = "\(firstValue) \(action) \(secondValue)"
    }

    private func generateValues() {
        firstValue = Int(arc4random_uniform(programSettings.maxValue))
        secondValue = Int(arc4random_uniform(programSettings.maxValue))
        action = ArithmeticActions.actions[Int(arc4random_uniform(4))].rawValue
    }

    private func checkValues() -> Bool {
        if action == "+", !programSettings.useAddition { return false }
        if action == "-", !programSettings.useSubstraction { return false }
        if action == "*", !programSettings.useMultiplication { return false }
        if action == "/", !programSettings.useDivision {
            return false
        } else if action == "/" {
            if secondValue == 0 || firstValue % secondValue != 0 || firstValue < secondValue { return false }
        }
        return true
    }

    private func arithmiticAction() -> Int {
        if action == "+" {
            return firstValue + secondValue
        } else if action == "-" {
            return firstValue - secondValue
        } else if action == "*" {
            return firstValue * secondValue
        } else {
            return firstValue / secondValue
        }
    }

    private func okButtonPressed() {
        programSettings.questions += 1
        var wrongUnswerAlert: UIAlertController
        if userInputLabel.text! == String(arithmiticAction()) {
            programSettings.rightAnswers += 1

            self.rightAnswerImageView.animationImages = [UIImage(named: "greenCheck")!]
            self.rightAnswerImageView.animationRepeatCount = 1
            self.rightAnswerImageView.animationDuration = 1
            self.rightAnswerImageView.startAnimating()

            self.getNewExample()
        } else {
            wrongAnswerImageView.isHidden = false

            wrongUnswerAlert = UIAlertController(title: "WRONG",
                                                 message: "It is not \(userInputLabel.text!)",
                                                preferredStyle: .alert)
            wrongUnswerAlert.addAction(UIAlertAction(title: "Think", style: .default, handler: { _ in
                self.wrongAnswerImageView.isHidden = true
            }))
            wrongUnswerAlert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { _ in
                self.wrongAnswerImageView.isHidden = true
                self.getNewExample()
            }))

            self.present(wrongUnswerAlert, animated: true, completion: nil)
        }
        userInputLabel.text = "0"
    }

    // MARK: - TextField controls

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

// MARK: - CollectionView controls

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonsLabels.count + 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == buttonsLabels.count {
            let identifire = NSStringFromClass(CollectionViewSettingssCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire,
                                                          for: indexPath)
                as! CollectionViewSettingssCell // swiftlint:disable:this force_cast
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.backgroundColor = .white
            return cell
        } else {
            let identifire = NSStringFromClass(CollectionViewCell.self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire,
                                                          for: indexPath)
                as! CollectionViewCell // swiftlint:disable:this force_cast
            cell.label.text = buttonsLabels[indexPath.row]
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.gray.cgColor
            cell.backgroundColor = .white
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == buttonsLabels.count {
            performSegue(withIdentifier: "forSettingsViewController", sender: self)
        }
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell,
            let cellText = cell.label.text else {
                return
        }
        if cellText == "C" {
            userInputLabel.text = "0"
        } else if cellText == "OK" {
            okButtonPressed()
        } else if cellText == "<-" {
            if userInputLabel.text?.count == 1 {
                userInputLabel.text! = "0"
            } else {
                userInputLabel.text!.remove(at: String.Index(encodedOffset: userInputLabel.text!.count - 1))
            }
        } else {
            if userInputLabel.text! == "0" {
                userInputLabel.text! = cellText
            } else {
                userInputLabel.text!.append(cellText)
            }
        }
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 4 - 1
        return CGSize(width: size, height: size)
    }
}

// MARK: - Segue controls

extension GameViewController: UIViewControllerTransitioningDelegate {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsViewController = segue.destination as? SettingsViewController else {
            let allert = UIAlertController(title: "Attention!",
                                           message: "The VC which we go is unreserved",
                                           preferredStyle: .alert)
            allert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(allert, animated: true, completion: nil)
            return
        }
        if segue.identifier == "forSettingsViewController" {
            settingsViewController.transitioningDelegate = self
            settingsViewController.programSettings = programSettings
        }
    }
}
