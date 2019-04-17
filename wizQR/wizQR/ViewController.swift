//
//  ViewController.swift
//  wizQR
//
//  Created by Fernando Martin Garcia Del Angel on 4/17/19.
//  Copyright © 2019 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var videoPreview: UIView!
    var stringURL = String()
    enum error {
        case noCameraAvailable
        case videoInputInitFailed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            
        }catch {
            print("Failed to scan the QR/Barcode")
        }
    }
    
    /**
        This function scans the output and segues to the linked view
        - Parameters:
            - captureOutput: (AVCaptureOutput) AV Object or Camera Stream
            - metadataObjects: [Any]! Any and all objects captured from the stream
            - connection (AVCaptureConnection) Connection with the camera
    */
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!){
        if metadataObjects.count > 0 {
            let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                stringUrl = machineReadableCode.stringValue!
                performSegue(withIdentifier: "openLink", sender: self)
            }
        }
    }


}

