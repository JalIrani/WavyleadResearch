//
//  SurveyTask.swift
//  WavyleafResearch
//
//  Created by Jal Irani on 12/20/15.
//  Copyright (c) 2015 Jal Irani. All rights reserved.
//

import ResearchKit

public var SurveyTask: ORKOrderedTask
{
    var steps = [ORKStep]()
    
    //add instructions step
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "The flu season Survey"
    instructionStep.text = "Please answer the following questions."
    steps += [instructionStep]
    
    // Reference from
    //https://github.com/ResearchKit/ResearchKit/blob/master/samples/ORKCatalog/ORKCatalog/TaskListRow.swift
    //Question: How are you feeling today
    let feelingQuestionText =  NSLocalizedString("How are you feeling today?", comment: "")
    let step1AnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: "", minimumValueDescription: "")
    let questionStep3 = ORKQuestionStep(identifier: "DiscreteScaleQuestionStep", title: feelingQuestionText, answer: step1AnswerFormat)
    
    steps += [questionStep3]
    
    //Question: What is your temperature
    let tempQuestionText =  NSLocalizedString("What is your temperature?", comment: "")
    let localizedQuestionStep1AnswerFormatUnit = NSLocalizedString("Fahrenheit", comment: "")
    let questionStep1AnswerFormat = ORKAnswerFormat.decimalAnswerFormatWithUnit(localizedQuestionStep1AnswerFormatUnit)
    let questionStep4 = ORKQuestionStep(identifier: "NumericQuestionTask", title: tempQuestionText, answer: questionStep1AnswerFormat)
    questionStep4.placeholder = NSLocalizedString("Your Temperature.", comment: "")
    steps += [questionStep4]
    
    //Question: Do you have runny nose
    let noseQuestionText =  NSLocalizedString("Do you have runny nose?", comment: "")
    let answerFormat = ORKBooleanAnswerFormat()
    let questionStep5 = ORKQuestionStep(identifier: "BooleanQuestionStep", title: noseQuestionText, answer: answerFormat)
    steps += [questionStep5]
    
    //How sore/achey your body is
    let bodyQuestionText =  NSLocalizedString("How sore/achey your body is?", comment: "")
    let step2AnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: "", minimumValueDescription: "")
    let questionStep6 = ORKQuestionStep(identifier: "DiscreteScaleQuestionStep1", title: bodyQuestionText, answer: step2AnswerFormat)
    steps += [questionStep6]
    
    //Question: Do you sleep well in night
    let sleepQuestionText = "Do you sleep well in the night?"
    let textChoices = [
        ORKTextChoice(text: "Yes", value: 1),
        ORKTextChoice(text: "No", value: 0),
        ORKTextChoice(text: "Uncomfortable", value: 2)
    ]
    let sleepAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: textChoices)
    let questionStep7 = ORKQuestionStep(identifier: "TextChoiceQuestionStep", title: sleepQuestionText, answer: sleepAnswerFormat)
    steps += [questionStep7]
    
    //Question: Do you have runny nose
    let weaknessQuestionText =  NSLocalizedString("Do you feel sick?", comment: "")
    let weaknessFormat = ORKBooleanAnswerFormat()
    let questionStep8 = ORKQuestionStep(identifier: "BooleanQuestionStep1", title: weaknessQuestionText, answer: weaknessFormat)
    steps += [questionStep8]
    
    //add summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    steps += [summaryStep]
    //println("***** steps=\(steps)")
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}