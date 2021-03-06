import Cocoa
import HaishinKit
import Foundation
import AVFoundation

final class RTMPAnalyzerViewController: NSViewController {
    @IBOutlet private weak var previewView: GLHKView!
    @IBOutlet private weak var playbackView: GLHKView!

    @IBOutlet private weak var audioPopUpButton: NSPopUpButton!
    @IBOutlet private weak var cameraPopUpButton: NSPopUpButton!
    @IBOutlet private weak var publishURLField: NSTextField!
    @IBOutlet private weak var publishStreamField: NSTextField!
    @IBOutlet private weak var playbackURLField: NSTextField!
    @IBOutlet private weak var playbackStreamField: NSTextField!

    private var publishConnection: RTMPConnection = RTMPConnection()
    private var publishStream: RTMPStream!
    private var playbackConnection: RTMPConnection = RTMPConnection()
    private var playbackStream: RTMPStream!

    override func viewDidLoad() {
        super.viewDidLoad()

        publishStream = RTMPStream(connection: publishConnection)
        publishStream.addObserver(self, forKeyPath: "currentFPS", options: .new, context: nil)

        playbackStream = RTMPStream(connection: playbackConnection)
        playbackStream.addObserver(self, forKeyPath: "currentFPS", options: .new, context: nil)

        let audios: [Any]! = AVCaptureDevice.devices(for: AVMediaType.audio)

        for audio in audios {
            if let audio: AVCaptureDevice = audio as? AVCaptureDevice {
                audioPopUpButton.addItem(withTitle: audio.localizedName)
            }
        }

        let cameras: [Any]! = AVCaptureDevice.devices(for: AVMediaType.video)
        for camera in cameras {
            if let camera: AVCaptureDevice = camera as? AVCaptureDevice {
                cameraPopUpButton.addItem(withTitle: camera.localizedName)
            }
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        publishStream.attachAudio(DeviceUtil.device(withLocalizedName: audioPopUpButton.itemTitles[audioPopUpButton.indexOfSelectedItem], mediaType: .audio))
        publishStream.attachCamera(DeviceUtil.device(withLocalizedName: cameraPopUpButton.itemTitles[cameraPopUpButton.indexOfSelectedItem], mediaType: .video))
        previewView.attachStream(publishStream)
        playbackView.attachStream(playbackStream)
    }

    @IBAction func selectAudio(_ sender: AnyObject) {
        let device: AVCaptureDevice? = DeviceUtil.device(withLocalizedName:
            audioPopUpButton.itemTitles[audioPopUpButton.indexOfSelectedItem], mediaType: .audio
        )
        publishStream.attachAudio(device)
    }

    @IBAction func selectCamera(_ sender: AnyObject) {
        let device: AVCaptureDevice? = DeviceUtil.device(withLocalizedName:
            cameraPopUpButton.itemTitles[cameraPopUpButton.indexOfSelectedItem], mediaType: .video
        )
        publishStream.attachCamera(device)
    }

    @IBAction func didGoClicked(_ sender: NSButton) {
    }
}
