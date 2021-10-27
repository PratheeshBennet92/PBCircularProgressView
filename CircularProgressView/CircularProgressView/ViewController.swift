import UIKit
class ViewController: UIViewController {
  var circularProgressBarView: PBCircularProgressView!
  var circularViewDuration: TimeInterval = 2
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpCircularProgressBarView()
    // Do any additional setup after loading the view.
  }
  func setUpCircularProgressBarView() {
    // set view
    circularProgressBarView = PBCircularProgressView(arcRadius: 20)
    // align to the center of the screen
    circularProgressBarView.center = view.center
    // call the animation with circularViewDuration
    // add this view to the view controller
    view.addSubview(circularProgressBarView)
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.circularProgressBarView.progress = 0.25
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.circularProgressBarView.progress = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.circularProgressBarView.progress = 0.75
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.circularProgressBarView.progress = 1
          }
        }
      }
    }
  }
}
