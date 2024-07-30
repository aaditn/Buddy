import AVFoundation
import SwiftUI

class CameraManager: NSObject, ObservableObject {
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    @Published var previewLayer = AVCaptureVideoPreviewLayer()
    @Published var capturedImage: UIImage?
    @Published var burstImages: [UIImage] = []
    
    private var deviceInput: AVCaptureDeviceInput?
    private var isBurstCapturing = false
    
    override init() {
        super.init()
        setupCamera()
    }
    
    private func setupCamera() {
        session.beginConfiguration()
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
                self.deviceInput = input
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            try camera.lockForConfiguration()
            if camera.activeFormat.videoMaxZoomFactor > 1.0 {
                camera.videoZoomFactor = 1.0
            }
            camera.unlockForConfiguration()

            previewLayer.session = session
            previewLayer.videoGravity = .resizeAspectFill
            session.commitConfiguration()
            session.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func startBurstCapture() {
        isBurstCapturing = true
        burstImages.removeAll()
        captureNextBurstPhoto()
    }
    
    func stopBurstCapture() {
        isBurstCapturing = false
    }
    
    private func captureNextBurstPhoto() {
        guard isBurstCapturing else { return }
        
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
        
        // Schedule the next capture immediately
        DispatchQueue.main.async {
            self.captureNextBurstPhoto()
        }
    }
}

extension CameraManager: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else { return }
        
        DispatchQueue.main.async {
            if self.isBurstCapturing {
                self.burstImages.append(image)
            } else {
                self.capturedImage = image
            }
        }
    }
}
