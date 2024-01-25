//
//  AddNewPublicationController.swift
//  InstaSimulatorByKazbek
//
//  Created by apple on 25.01.2024.
//

protocol AddNewPublicationProtocol {
    func popController()
}

import UIKit
import AVFoundation

class AddNewPublicationController: UIViewController, AddNewPublicationProtocol {
    
    func popController() {
        self.navigationController?.popViewController(animated: true)
    }

    
    var cameraPosition: AVCaptureDevice.Position = .back // Use initial position
    
    // Session
    var session: AVCaptureSession!
    
    // Preview
    var preview: AVCaptureVideoPreviewLayer!
    
    // Output
    var output = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 19/255, green: 20/255, blue: 22/255, alpha: 1)
        settupView()
    }
    
    private func settupView() {
        createCamera()
        view.addSubview(backBtn)
        view.addSubview(useDefultPhoto)
        view.addSubview(changeCamera)
        view.addSubview(shutBtn)
        
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            useDefultPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            useDefultPhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            changeCamera.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            changeCamera.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            shutBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            shutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private lazy var shutBtn: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "flame.circle"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .white
        $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return $0
    }(UIButton(primaryAction: actionShutBtn))
    
    private lazy var actionShutBtn = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    private lazy var changeCamera: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "camera.rotate.fill"), for: .normal)
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 34).isActive = true
        return $0
    }(UIButton(primaryAction: actionChangeCamera))
    
    private lazy var actionChangeCamera = UIAction { [weak self] _ in
        
        guard let self = self else { return }
        
        var positin: AVCaptureDevice.Position = (self.cameraPosition == .back) ? .front : .back
        self.cameraPosition = positin
        
        self.session.beginConfiguration()
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: positin) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            for input in self.session.inputs {
                self.session.removeInput(input)
            }
            if session.canAddInput(input) {
                session.addInput(input)
            }
            self.session.commitConfiguration()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private lazy var useDefultPhoto: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return $0
    }(UIButton(primaryAction: actionUseDefaultPhoto))
    
    private lazy var actionUseDefaultPhoto = UIAction { [weak self] _ in
        guard let self = self else { return }
        let alertController = UIAlertController(title: "Хотите выбрать стандартную фотку?", message: nil, preferredStyle: .actionSheet)
        let alert = UIAlertAction(title: "Да", style: .default) { _ in
            let vc = SettupPublication()
            if let image = UIImage(named: "img1") {
                vc.configView(image: image)
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        let notBtn = UIAlertAction(title: "Нет", style: .cancel)
        alertController.addAction(alert)
        alertController.addAction(notBtn)
        present(alertController, animated: true)
    }
    
    private lazy var backBtn: UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "arrow.backward.square"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        $0.tintColor = .white
        return $0
    }(UIButton(primaryAction: actionBackBtn))
    
    private lazy var actionBackBtn = UIAction {  _ in
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createCamera() {
        session = AVCaptureSession()
        
        session.sessionPreset = .hd4K3840x2160
        
        guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            if session.canAddInput(input), session.canAddOutput(output) {
                session.addInput(input)
                session.addOutput(output)
            }
            
            
            preview = AVCaptureVideoPreviewLayer(session: session)
            preview.videoGravity = .resizeAspect
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.session.startRunning()
            }
            
            preview.frame = view.bounds
            view.layer.addSublayer(preview)
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

extension AddNewPublicationController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        
        if let image = UIImage(data: data) {
            let vc = SettupPublication()
            vc.configView(image: image)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
