import UIKit
public class PBCircularProgressView: UIView {
  var arcRadius: CGFloat
  var lineWidth: CGFloat
  var circleStrokeColor: UIColor
  var progressStrokeColor: UIColor
  var progress: CGFloat = 0 {
    didSet {
      progressLayer.strokeEnd = progress
      self.progressAnimation()
    }
  }
  private var circularPath = UIBezierPath()
  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  private var startPoint = CGFloat(-Double.pi / 2)
  private var endPoint = CGFloat(3 * Double.pi / 2)
  init(arcRadius: CGFloat = 20,
       lineWidth: CGFloat = 10,
       circleStrokeColor: UIColor = .white,
       progressStrokeColor: UIColor = .red) {
    self.arcRadius = arcRadius
    self.lineWidth = lineWidth
    self.circleStrokeColor = circleStrokeColor
    self.progressStrokeColor = progressStrokeColor
    super.init(frame: .zero)
    createCircularPath()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  func createCircularPath() {
    // created circularPath for circleLayer and progressLayer
    circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 20, startAngle: startPoint, endAngle: endPoint, clockwise: true)
    // circleLayer path defined to circularPath
    circleLayer.path = circularPath.cgPath
    // ui edits
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineCap = .round
    circleLayer.lineWidth = self.lineWidth
    circleLayer.strokeEnd = 1.0
    circleLayer.strokeColor = circleStrokeColor.cgColor
    // added circleLayer to layer
    layer.addSublayer(circleLayer)
    // progressLayer path defined to circularPath
    progressLayer.path = circularPath.cgPath
    // ui edits
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineCap = .round
    progressLayer.lineWidth = self.lineWidth
    progressLayer.strokeEnd = progress
    progressLayer.strokeStart = 0
    progressLayer.strokeColor = progressStrokeColor.cgColor
    // added progressLayer to layer
    layer.addSublayer(progressLayer)
  }
  func progressAnimation(duration: TimeInterval = 0.5) {
    // created circularProgressAnimation with keyPath
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    // set the end time
    circularProgressAnimation.duration = duration
    circularProgressAnimation.toValue = progress
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
  }
}
