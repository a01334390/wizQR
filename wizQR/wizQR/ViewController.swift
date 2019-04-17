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
    
    enum error : Error{
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
                stringURL = machineReadableCode.stringValue!
                performSegue(withIdentifier: "openLink", sender: self)
            }
        }
    }
    
    /**
        Scans the QR code from the camera
    */
    func scanQRCode() throws {
        let avCaptureSession = AVCaptureSession()
        guard let avCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("There's no camera")
            throw error.noCameraAvailable
        }
        guard let avCaptureInput = try? AVCaptureDeviceInput(device: avCaptureDevice) else {
            print("Failed to initiate camera")
            throw error.videoInputInitFailed
        }
        
        let avCaptureMetadataOutput = AVCaptureMetadataOutput()
        avCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        avCaptureSession.addInput(avCaptureInput)
        avCaptureSession.addOutput(avCaptureMetadataOutput)
        
        avCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let avCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: avCaptureSession)
        avCaptureVideoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        avCaptureVideoPreviewLayer.frame = videoPreview.bounds
        self.videoPreview.layer.addSublayer(avCaptureVideoPreviewLayer)
        avCaptureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openLink" {
            let destination = segue.destination as! WebViewController
            destination.url = URL(string: stringURL)
        }
    }


}

