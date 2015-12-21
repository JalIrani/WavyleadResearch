//
//  ResearchViewController.swift
//  WavyleafResearch
//
//  Created by Jal Irani on 12/20/15.
//  Copyright (c) 2015 Jal Irani. All rights reserved.
//

import UIKit
import ResearchKit

class ResearchViewController: UIViewController {

    var consentTaskViewController:ORKTaskViewController!
    var surveyTaskViewController:ORKTaskViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Starting Consent Controller
    @IBAction func startDemo(sender: AnyObject) {
        consentTaskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        consentTaskViewController.delegate = self
        presentViewController(consentTaskViewController, animated: true, completion: nil)
    }
    
    func presentSurvey() {
        surveyTaskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        surveyTaskViewController.delegate = self
        presentViewController(surveyTaskViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ResearchViewController : ORKTaskViewControllerDelegate
{
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?)
    {
        //let data = NSKeyedArchiver.archivedDataWithRootObject(taskViewController.result)
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
        if reason != ORKTaskViewControllerFinishReason.Discarded
        {
            if consentTaskViewController != nil && consentTaskViewController == taskViewController
            {
                // Writing data into Consent.pdf file
                let taskResult = taskViewController.result
                //ConsentDocumentParticipantSignature
                var signatureResult : ORKConsentSignatureResult = taskResult.stepResultForStepIdentifier("ConsentReviewStep")?.firstResult as! ORKConsentSignatureResult
                let document = ConsentDocument.copy() as! ORKConsentDocument
                signatureResult.applyToDocument(document)
                document.makePDFWithCompletionHandler({ (pdfData:NSData?, error: NSError?) -> Void in
                    var docURL = (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last as? NSURL
                    docURL = docURL?.URLByAppendingPathComponent( "Consent.pdf")
                    println("This is doc URL " + String(stringInterpolationSegment: docURL))
                    //write file to the disk.
                    pdfData?.writeToURL(docURL!, atomically: true)
                    //now you can see that pdf in your applications directory
                })
                presentSurvey()
            }
            if surveyTaskViewController != nil && surveyTaskViewController == taskViewController
            {
                // Store Survey
                let data = NSKeyedArchiver.archivedDataWithRootObject(taskViewController.result)
                let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] .stringByAppendingPathComponent("Survey")
                data.writeToFile(documentsPath, atomically: false)
            }
        }
    }
}
