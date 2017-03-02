import UIKit
import Gecco
import Spring


class WalkThroughViewController: SpotlightViewController {

    @IBOutlet var annotationViews: [UIView]!
    @IBOutlet weak var allowButton: SpringButton!

    var stepIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func next(_ labelAnimated: Bool) {
        updateAnnotationView(labelAnimated)
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        
        // カレンダーと投稿画面の比から計算
        // コーチマークの四角形の幅と高さ
        let rectWidth: CGFloat = screenSize.width * 0.95
        let rectHeight: CGFloat = screenSize.height * 0.46
        
        let settingRectWidth: CGFloat = screenSize.width * 0.1
        
        // 四角形のY軸の中心点座標
        let calendarRectCenterY: CGFloat = screenSize.height * 0.31
        let postRectCenterY:CGFloat = screenSize.height * 0.77
        
        switch stepIndex {
        case 0:
            spotlightView.appear(Spotlight.RoundedRect(center: CGPoint(x: screenSize.width / 2, y: calendarRectCenterY), size: CGSize(width: rectWidth, height: rectHeight), cornerRadius: 6))
        case 1:
            spotlightView.move(Spotlight.RoundedRect(center: CGPoint(x: screenSize.width / 2, y: postRectCenterY), size: CGSize(width: rectWidth, height: rectHeight), cornerRadius: 6))
        case 2:
            spotlightView.move(Spotlight.RoundedRect(center: CGPoint(x: screenSize.width * 0.96, y: postRectCenterY), size: CGSize(width: settingRectWidth, height: rectHeight), cornerRadius: 6))

            self.allowButton.setTitleColor(UIColor.white, for: .normal)
            self.allowButton.animation = "slideLeft"
            self.allowButton.repeatCount = 5
            self.allowButton.animate()
            
        case 3:
            dismiss(animated: true, completion: nil)
            
        default:
            break
        }
        
        self.stepIndex += 1
    }
    
    func updateAnnotationView(_ animated: Bool) {
        annotationViews.enumerated().forEach { index, view in
            UIView.animate(withDuration: animated ? 0.5 : 0) {
                view.alpha = index == self.stepIndex ? 1 : 0
            }
        }
    }
}

extension WalkThroughViewController: SpotlightViewControllerDelegate {
    func spotlightViewControllerWillPresent(_ viewController: SpotlightViewController, animated: Bool) {
        next(false)
    }
    
    func spotlightViewControllerTapped(_ viewController: SpotlightViewController, isInsideSpotlight: Bool) {
        next(true)
    }
    
    func spotlightViewControllerWillDismiss(_ viewController: SpotlightViewController, animated: Bool) {
        spotlightView.disappear()
    }
}
