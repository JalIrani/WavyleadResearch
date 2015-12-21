//
//  ConsentTask.swift
//  WavyleafResearch
//
//  Created by Jal Irani on 12/20/15.
//  Copyright (c) 2015 Jal Irani. All rights reserved.
//

import ResearchKit

public var ConsentTask: ORKOrderedTask
{
    var steps = [ORKStep]()
    
    //Add VisualConsentStep
    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    //Add ConsentReviewStep
    let signature = consentDocument.signatures!.first as! ORKConsentSignature
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
    
    reviewConsentStep.text = "Review Consent!"
    reviewConsentStep.reasonForConsent = "You must be at least 18 years of age to participate in this study"
    
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier: "ConsentTask", steps: steps)
}