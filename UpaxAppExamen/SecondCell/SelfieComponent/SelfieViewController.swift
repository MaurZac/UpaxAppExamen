//
//  SelfieViewController.swift
//  UpaxAppExamen
//
//  Created by MaurZac on 19/12/21.
//

import UIKit
import AVFoundation

class SelfieViewController: UIViewController, UINavigationControllerDelegate {
    
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
    
    
    func activaCam() {
      let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame  = view.bounds
        
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async { [self] in
                    self.setUpCamera()
                    activaCam()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
            DispatchQueue.main.async {
                self.activaCam()
            }
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
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
extension SelfieViewController: AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        photoTime.image = image
    }
    
    
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        let image = UIImage(data: data)
        
        session?.stopRunning()
        
        let imageView = UIImageView(image: takenphoto)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
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

