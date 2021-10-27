import UIKit
class ViewController: UIViewController {
  var circularProgressBarView: PBCircularProgressView!
  var progressAnimationDuration: TimeInterval = 2
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCircularProgressBarView()
    // Do any additional setup after loading the view.
  }
  func setUpCircularProgressBarView() {
    // set view
    circularProgressBarView = PBCircularProgressView(arcRadius: 20,
                                                     lineWidth: 5,
                                                     circleStrokeColor: .lightGray,
                                                     progressStrokeColor: .red,
                                                     progressAnimationDuration: 0.35)
    circularProgressBarView.pauseDownloadButtonAction = { pauseStatus, progressStatus in
      print(pauseStatus, progressStatus)
    }
    circularProgressBarView.pauseDownloadButtonSize = CGSize(width: 35, height: 35)
    view.addSubview(circularProgressBarView)
    circularProgressBarView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    circularProgressBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    circularProgressBarView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    circularProgressBarView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.circularProgressBarView.progress = 0.25
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.circularProgressBarView.progress = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
          self.circularProgressBarView.progress = 0.75
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.circularProgressBarView.progress = 1
          }
        }
      }
    }
  }
}
