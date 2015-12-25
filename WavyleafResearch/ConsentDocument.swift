//
//  ConsentDocument.swift
//  WavyleafResearch
//
//  Created by Jal Irani on 12/20/15.
//  Copyright (c) 2015 Jal Irani. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument
{
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Consent"
    
    //Can put anything in here
    let consentSectionTypes: [ORKConsentSectionType] = [
        .Overview,
        .DataGathering,
        //.Privacy,
        .DataUse,
        //.TimeCommitment,
        .StudySurvey,
        .StudyTasks
        //.Withdrawing
    ]
    
    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "If you wish to complete this study..."
        consentSection.content = "Dr. Beauchamp can fill this part in"
        return consentSection
    }
    
    consentDocument.sections = consentSections
    
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}