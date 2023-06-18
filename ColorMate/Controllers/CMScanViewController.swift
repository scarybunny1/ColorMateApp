//
//  CMScanViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit
import AVFoundation

class CMScanViewController: CMViewController {
    
    //Capture session
    var session: AVCaptureSession?
    //Photo Output
    let output = AVCapturePhotoOutput()
    //Video Preview
    let previewLayer = AVCaptureVideoPreviewLayer()
    //Shutter button
    let shutterButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 50
        b.layer.borderWidth = 10
        b.layer.borderColor = UIColor.white.cgColor
        b.backgroundColor = .black
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        checkCameraPermissions()
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpViews()
    }
    
    func setUpViews() {
        previewLayer.frame = view.bounds
        shutterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shutterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shutterButton.heightAnchor.constraint(equalToConstant: 100),
            shutterButton.widthAnchor.constraint(equalTo: shutterButton.heightAnchor)
        ])

        shutterButton.addTarget(self, action: #selector(didTapShutterButton), for: .touchUpInside)
    }
    
    func setUpLayout() {
        
    }
    
    func applyTheme() {
        view.backgroundColor = .yellow
    }
    
    private func checkCameraPermissions(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            //Request
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else{
                    return
                }
                self?.setUpCamera()
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
    
    private func setUpCamera(){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
//                let videoOutput = AVCaptureVideoDataOutput()
//                videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
//                session.addOutput(videoOutput)
                
                previewLayer.session = session
                previewLayer.videoGravity = .resizeAspectFill
                DispatchQueue.global(qos: .background).async {
                    session.startRunning()
                }
                
                self.session = session
            }
            catch{
                print(error)
            }
        }
    }
    
    @objc private func didTapShutterButton(){
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
    }
    
}

extension CMScanViewController: AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        guard let image = UIImage(data: data) else{return}
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        view.addSubview(imageView)
        let center_point = CGPoint(x: image.size.height / 2, y: image.size.width / 2)
        let rgba = image.getPixelColor(pos: center_point)
        
        showColorDetailsBottomSheet(for: rgba)
        session?.stopRunning()
    }
    
    private func showColorDetailsBottomSheet(for color_rgba: RGBA){
        let detailVC = CMColorDetailViewController(rgba: color_rgba)
        
        let nav = UINavigationController(rootViewController: detailVC)
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        present(nav, animated: true)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            // Check if the camera is focused before processing the frame
            guard connection.isVideoOrientationSupported,
                  connection.isActive,
                  connection.isVideoMirroringSupported,
                  connection.isVideoMirrored == false,
                  connection.isEnabled else {
                return
            }

            // Convert sample buffer to a pixel buffer
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

            // Get the center pixel coordinates
            let pixelWidth = CVPixelBufferGetWidth(pixelBuffer)
            let pixelHeight = CVPixelBufferGetHeight(pixelBuffer)
            let centerX = pixelWidth / 2
            let centerY = pixelHeight / 2

            // Lock the base address for efficient pixel access
            CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)

            // Get the RGB values of the center pixel
            if let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer) {
                let bytesPerPixel = 4 // Assuming 4 bytes per pixel (32-bit RGBA)
                let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
                let pixelAddress = baseAddress.advanced(by: (centerY * bytesPerRow) + (centerX * bytesPerPixel))

                let pixelData = UnsafeBufferPointer(start: pixelAddress.assumingMemoryBound(to: UInt8.self), count: bytesPerPixel)
                let red = pixelData[0]
                let green = pixelData[1]
                let blue = pixelData[2]

                print("RGB values - R: \(red), G: \(green), B: \(blue)")
            }

            // Unlock the base address after accessing the pixel data
            CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        }
}
