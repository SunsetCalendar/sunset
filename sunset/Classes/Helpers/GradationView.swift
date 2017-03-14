import UIKit

class GradationView {

    let gradientColors: [CGColor]
    let gradientLayer: CAGradientLayer

    init(topColor: UIColor, bottomColor: UIColor) {
        self.gradientColors = [topColor.cgColor, bottomColor.cgColor]
        self.gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
    }

    func addGradation(view: UIView) {
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
