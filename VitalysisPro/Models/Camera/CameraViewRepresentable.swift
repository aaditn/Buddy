import AVFoundation
import SwiftUI

struct CameraViewRepresentable: UIViewControllerRepresentable {
    @ObservedObject var cameraManager: CameraManager

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let previewLayer = cameraManager.previewLayer
        
        // Configure the preview layer
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = controller.view.bounds
        
        // Add the preview layer to the view controller's view
        controller.view.layer.addSublayer(previewLayer)
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        DispatchQueue.main.async {
            self.cameraManager.previewLayer.frame = uiViewController.view.bounds
        }
    }
}
