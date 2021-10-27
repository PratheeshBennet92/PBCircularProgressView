import UIKit
public class PBCircularProgressView: UIView {
  /// To hide the pauseDownloadButton. Default is False
  var hidePauseDownloadButton: Bool = false {
    didSet {
      self.isHidden = hidePauseDownloadButton
    }
  }
  /// To set the pauseDownloadButton width and height
  var pauseDownloadButtonSize: CGSize = CGSize(width: 35, height: 35) {
    didSet {
      pauseDownloadButton.widthAnchor.constraint(equalToConstant: pauseDownloadButtonSize.width).isActive = true
      pauseDownloadButton.heightAnchor.constraint(equalToConstant: pauseDownloadButtonSize.height).isActive = true
    }
  }
  private var isPaused: Bool = false
  /// PauseDownloadButton Action Callback
  var pauseDownloadButtonAction: ((Bool) -> Void)?
  var progressAnimationDuration: TimeInterval = 0.35
  lazy private var pauseDownloadButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "pause")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.contentHorizontalAlignment = .fill
    button.contentVerticalAlignment = .fill
    button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(pauseDownloadTapped), for: .touchUpInside)
    return button
  }()
  private var arcRadius: CGFloat
  private var lineWidth: CGFloat
  private var circleStrokeColor: UIColor
  private var progressStrokeColor: UIColor
  private var previousProgress: CGFloat = 0
  var progress: CGFloat = 0 {
    didSet {
      self.progressAnimation()
    }
  }
  private var circularPath = UIBezierPath()
  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  private var startPoint = CGFloat(-Double.pi / 2)
  private var endPoint = CGFloat(3 * Double.pi / 2)
  init(arcRadius: CGFloat = 20,
       lineWidth: CGFloat = 5,
       circleStrokeColor: UIColor = .lightGray,
       progressStrokeColor: UIColor = .red,
       progressAnimationDuration: TimeInterval = 0.35) {
    self.arcRadius = arcRadius
    self.lineWidth = lineWidth
    self.circleStrokeColor = circleStrokeColor
    self.progressStrokeColor = progressStrokeColor
    self.progressAnimationDuration = progressAnimationDuration
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    addDownloadPauseButton()
    createCircularPath()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  public override func layoutSubviews() {
    super.layoutSubviews()
    createCircularPath()
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
  func progressAnimation() {
    // created circularProgressAnimation with keyPath
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    // set the end time
    circularProgressAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: "easeInEaseOut"))
    progressLayer.strokeColor = progressStrokeColor.cgColor
    circularProgressAnimation.duration = progressAnimationDuration
    circularProgressAnimation.fromValue = previousProgress
    circularProgressAnimation.toValue = progress
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    CATransaction.setCompletionBlock{ [weak self] in
      guard let self = self else { return }
      self.previousProgress = self.progress
    }
    progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
  }
  private func addDownloadPauseButton() {
    self.addSubview(pauseDownloadButton)
    pauseDownloadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    pauseDownloadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
  }
  @objc private func pauseDownloadTapped() {
    isPaused = !isPaused
    isPaused ? pauseDownloadButton.setImage(UIImage(named: "play")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal) :  pauseDownloadButton.setImage(UIImage(named: "pause")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
    self.pauseDownloadButtonAction?(isPaused)
  }
}
