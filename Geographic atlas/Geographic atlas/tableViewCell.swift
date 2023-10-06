import UIKit

class tableViewCell: UITableViewCell {
    
    var cellImageView = UIImageView()
    var cellTitlelabel = UILabel()
    var cellSubtitle = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Create custom shape using a path
        let maskPath = UIBezierPath(roundedRect: bounds, cornerRadius: 15.0)

        // Create shape layer with the path
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath

        // Apply the mask to the cell's contentView
        layer.mask = maskLayer

        // Change the background color of the cell's contentView
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cellImageView)
        addSubview(cellTitlelabel)
        addSubview(cellSubtitle)
        
        
        configureImageView()
        configureTitlelabel()
        configureSubtitle()
        
        setimageConstraint()
        setTitleConstraints()
        setSubtitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(country: Country){
//unwrapping flag
        guard let flag = country.flags?.png else {
            print("flag is not loaded")
            return
        }
        let url = URL(string: flag)
        downloadImage(from: url!) { image in
            DispatchQueue.main.async {
                self.cellImageView.image = image
            }
        }
        
//unwrapping name
        guard let name = country.name else {
            print("name was not loaded")
            return
        }
        cellTitlelabel.text = name
        
//unwrapping title
        guard let title = country.capital else {
            print("subtitle was not loaded")
            return
        }
        cellSubtitle.text = title
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle error
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                // Handle invalid or empty image data
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
    func configureImageView(){
        cellImageView.layer.cornerRadius = 10
        cellImageView.clipsToBounds      = true
    }
    
    func configureTitlelabel(){
        cellTitlelabel.numberOfLines = 0
        cellTitlelabel.adjustsFontSizeToFitWidth = true
        cellTitlelabel.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureSubtitle(){
        cellSubtitle.numberOfLines = 0
        cellSubtitle.adjustsFontSizeToFitWidth = true
        cellSubtitle.font = UIFont.systemFont(ofSize: 13)
        cellSubtitle.textColor = UIColor.gray
    }
    
    func setimageConstraint(){
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            cellImageView.heightAnchor.constraint(equalToConstant: 48),
            cellImageView.widthAnchor.constraint(equalTo: cellImageView.heightAnchor, multiplier: 16/9)
        ])
    }
    
    func setTitleConstraints(){
        cellTitlelabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellTitlelabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            cellTitlelabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            cellTitlelabel.heightAnchor.constraint(equalToConstant: 20),
            cellTitlelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

        ])
        
    }
    
    func setSubtitleConstraints(){
        cellSubtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellSubtitle.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 20),
            cellSubtitle.heightAnchor.constraint(equalToConstant: 16),
            cellSubtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cellSubtitle.topAnchor.constraint(equalTo: centerYAnchor, constant: 4)

        ])
        
    }
    
}
