import UIKit

class GradationView {

    func addGradation(view: UIView) {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()

        gradientLayer.colors = gradientColors
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addGradation(view: UITableView) {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()

        gradientLayer.colors = gradientColors
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
