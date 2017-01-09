import UIKit
import Gecco

class WalkThroughViewController: SpotlightViewController {
    
    @IBOutlet var annotationViews: [UIView]!
    
    var stepIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func next(_ labelAnimated: Bool) {
        updateAnnotationView(labelAnimated)

        let screenSize = UIScreen.main.bounds.size

        // カレンダーと投稿画面の比から計算
        // コーチマークの四角形の幅と高さ
        let rectWidth = screenSize.width * 0.95
        let rectHeight = screenSize.height * 0.46

        // 四角形のY軸の中心点座標
        let calendarRectCenterY = screenSize.height * 0.31
        let postRectCenterY = screenSize.height * 0.77

        switch stepIndex {
        case 0:
            spotlightView.appear(Spotlight.RoundedRect(center: CGPoint(x: screenSize.width / 2, y: calendarRectCenterY), size: CGSize(width: rectWidth, height: rectHeight), cornerRadius: 6))
        case 1:
            spotlightView.move(Spotlight.RoundedRect(center: CGPoint(x: screenSize.width / 2, y: postRectCenterY), size: CGSize(width: rectWidth, height: rectHeight), cornerRadius: 6))
        case 2:
            dismiss(animated: true, completion: nil)
        default:
            break
        }

        self.stepIndex += 1
    }

    func updateAnnotationView(_ animated: Bool) {
        annotationViews.enumerated().forEach { index, view in
            UIView.animate(withDuration: animated ? 0.5 : 0) {
                view.alpha = index == self.stepIndex ? 0 : 1
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
