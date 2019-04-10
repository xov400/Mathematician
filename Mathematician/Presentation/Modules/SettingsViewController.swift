//
//  Created by Александр on 04.09.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet weak var numOfQuestionsLabel: UILabel!
    @IBOutlet weak var numOfRightAnswersLabel: UILabel!
    @IBOutlet weak var useAdditionSwitch: UISwitch!
    @IBOutlet weak var useSubstractionSwitch: UISwitch!
    @IBOutlet weak var useMultiplicationSwitch: UISwitch!
    @IBOutlet weak var useDivisionSwitch: UISwitch!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textField: UITextField!

    var programSettings = ProgramSettings()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numOfQuestionsLabel.text = "Number of questions - \(programSettings.questions)"
        numOfRightAnswersLabel.text = "Number of right answers - \(programSettings.rightAnswers)"
        stepper.value = Double(programSettings.maxValue)
        textField.text = String(programSettings.maxValue)
        useAdditionSwitch.isOn = programSettings.useAddition
        useSubstractionSwitch.isOn = programSettings.useSubstraction
        useMultiplicationSwitch.isOn = programSettings.useMultiplication
        useDivisionSwitch.isOn = programSettings.useDivision
    }

    @IBAction func switchersChanged(_ sender: UISwitch) {
        if sender.restorationIdentifier == "addition",
            (useSubstractionSwitch.isOn || useMultiplicationSwitch.isOn || useDivisionSwitch.isOn) {
            programSettings.useAddition = sender.isOn
        } else if sender.restorationIdentifier == "substraction",
            (useAdditionSwitch.isOn || useMultiplicationSwitch.isOn || useDivisionSwitch.isOn) {
            programSettings.useSubstraction = sender.isOn
        } else if sender.restorationIdentifier == "multiplication",
            (useSubstractionSwitch.isOn || useAdditionSwitch.isOn || useDivisionSwitch.isOn) {
            programSettings.useMultiplication = sender.isOn
        } else if sender.restorationIdentifier == "division",
            (useSubstractionSwitch.isOn || useMultiplicationSwitch.isOn || useAdditionSwitch.isOn) {
            programSettings.useDivision = sender.isOn
        } else {
            let allertController = UIAlertController(title: "Atantion!",
                                                     message: "At least one action must be enabled.",
                                                     preferredStyle: .alert)
            allertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(allertController, animated: true, completion: { sender.isOn = true })
        }
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        programSettings.maxValue = UInt32(sender.value)
        textField.text = String(programSettings.maxValue)
    }
}
