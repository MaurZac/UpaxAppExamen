//
//  SelfieViewController.swift
//  UpaxAppExamen
//
//  Created by MaurZac on 19/12/21.
//

import UIKit
import AVFoundation

class SelfieViewController: UIViewController {
    
    var takenphoto: UIImage?
    @IBOutlet weak var photoTime: UIImageView!
    
//    let captureSession = AVCaptureSession()
//    var previewLayer: CALayer!
//    var captureDevice: AVCaptureDevice!
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let availabe = takenphoto {
            photoTime.image = availabe
        }
        checkCameraPermissions()
//        prepareCamera()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame  = view.bounds
        
    }
    
    
    
    func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input =  try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}


//    func prepareCamera() {
//        captureSession.sessionPreset = AVCaptureSession.Preset.photo
//        if let availabeDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .front).devices.first {
//            captureDevice = availabeDevices
//            beginSession()
//        }
//    }

//    func beginSession() {
//        do {
//            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
//            captureSession.addInput(captureDeviceInput)
//        }catch{
//            print(error.localizedDescription)
//        }
//
//          let previewLayer = AVCaptureVideoPreviewLayer()
//            previewLayer.session = captureSession
//            self.previewLayer = previewLayer
//            self.view.layer.addSublayer(self.previewLayer)
//            self.previewLayer.frame = self.view.layer.frame
//            captureSession.startRunning()
//
//            let dataOutput = AVCaptureVideoDataOutput()
//            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as String): NSNumber(value: kCVPixelFormatType_32BGRA)]
//
//            dataOutput.alwaysDiscardsLateVideoFrames = true
//
//            if captureSession.canAddOutput(dataOutput) {
//                captureSession.addOutput(dataOutput)
//            }
//
//            captureSession.commitConfiguration()
//
//    }

