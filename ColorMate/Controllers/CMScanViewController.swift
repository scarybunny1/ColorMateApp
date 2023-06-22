//
//  CMScanViewController.swift
//  ColorMate
//
//  Created by Ayush Bhatt on 16/06/23.
//

import UIKit
import AVFoundation

class CMScanViewController: CMViewController {
    
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    let shutterButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = 50
        b.layer.borderWidth = 10
        b.layer.borderColor = UIColor.white.cgColor
        b.backgroundColor = .black
        return b
    }()
    var capturedImageView: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        return iv
    }()
    
    let crosshairView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 10
        v.backgroundColor = .clear
        v.layer.borderColor = UIColor.white.cgColor
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        checkCameraPermissions()
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(capturedImageView)
        view.addSubview(crosshairView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpViews()
    }
    
    func setUpViews() {
        previewLayer.frame = view.bounds
        capturedImageView.frame = view.bounds
        shutterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shutterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shutterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shutterButton.heightAnchor.constraint(equalToConstant: 100),
            shutterButton.widthAnchor.constraint(equalTo: shutterButton.heightAnchor)
        ])

        shutterButton.addTarget(self, action: #selector(didTapShutterButton), for: .touchUpInside)
        crosshairView.center = view.center
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
        capturedImageView.image = image
        capturedImageView.isHidden = false
        let center_point = CGPoint(x: image.size.height / 2, y: image.size.width / 2)
        let rgba = image.getPixelColor(pos: center_point)
        
        showColorDetailsBottomSheet(for: rgba)
        session?.stopRunning()
    }
    
    private func showColorDetailsBottomSheet(for color_rgba: RGBA){
        let detailVC = CMColorDetailViewController(rgba: color_rgba)
        detailVC.delegate = self
        
        let nav = UINavigationController(rootViewController: detailVC)
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        present(nav, animated: true)
    }
    
}

extension CMScanViewController: CMColorDetailViewControllerDelegate{
    func colorDetailVC(_ vc: CMColorDetailViewController, didGetDismissed: Bool) {
        capturedImageView.isHidden = true
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.session?.startRunning()
        }
        
    }
}
