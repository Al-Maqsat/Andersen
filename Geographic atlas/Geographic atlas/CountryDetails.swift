import UIKit

class CountryDetails: UIViewController{
    var region = UILabel()
    var capital = UILabel()
    var capitalCoordinates = UILabel()
    var Population = UILabel()
    var area = UILabel()
    var currency = UILabel()
    var timezones = UILabel()
    var imageOfTheFlag = UIImageView()
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let country = country else {
            print("Variable country was not received from mainVC")
            return
        }
        title = country.name
        
        configureCountryDetails()
    }
    
    func configureCountryDetails(){

        view.addSubview(region)
        view.addSubview(capital)
        view.addSubview(capitalCoordinates)
        view.addSubview(Population)
        view.addSubview(area)
        view.addSubview(currency)
        view.addSubview(timezones)
        view.addSubview(imageOfTheFlag)
        
        //Configuring
        configureRegion()
        configureCapital()
        configureCapitalCoordinates()
        configurePopulation()
        configureArea()
        configureCurrency()
        configureTimezones()
        configureImageOfTheFlag()
        
        //Setting constraints
        setimageOfTheFlagConstraint()
        setregionConstraint()
        setcapitalConstraint()
        setcapitalCoordinatesConstraint()
        setPopultaionConstraint()
        setAreaConstraint()
        setCurrencyConstraint()
        setTimezones()
        
        //unwrapping flag
        guard let flag = country?.flags?.png else {
            print("flag is not loaded")
            return
        }
        let url = URL(string: flag)
        downloadImage(from: url!) { image in
            DispatchQueue.main.async {
                self.imageOfTheFlag.image = image
            }
        }
        
        //        unwrapping region
        guard let reg = country?.region else {
            print("region was not loaded")
            return
        }
        properFonts(title: "Region:", information: reg, labelName: region)
        
        //        unwrapping capital
        guard let cap = country?.capital else {
            print("capital was not loaded")
            return
        }
        properFonts(title: "Capital:", information: cap, labelName: capital)
        
        //        unwrapping Capital Coordinates
        guard let capCor = country?.latlng else {
            print("Capital Coordinates were not loaded")
            return
        }
        
        let roundedNumberLat = String(format: "%.2f", capCor[0])
        let LatWithDegree = roundedNumberLat.replacingOccurrences(of: ".", with: "°")
        let roundedNumberLng = String(format: "%.2f", capCor[1])
        let LngWithDegree = roundedNumberLng.replacingOccurrences(of: ".", with: "°")
        
        let capCorText = "\(LatWithDegree)′, \(LngWithDegree)′"


        properFonts(title: "Capital Coordinates:", information: capCorText, labelName: capitalCoordinates)

        
        //        unwrapping population
        guard let pop = country?.population else {
            print("population was not loaded")
            return
        }
        let populationInMillions = Double(pop)/1_000_000
        let populationInMillionsReduced = Double(String(format: "%.2f", populationInMillions))!
        let populationFinalText = "\(populationInMillionsReduced) mln"
        
        properFonts(title: "Population:", information: populationFinalText, labelName: Population)
        
        
        
        //        unwrapping area
        guard let Area = country?.area else {
            print("area was not loaded")
            return
        }
        
        let areaText = "\(groupLargeNumber(number: Int(Area))) km\u{00B2}"
        
        properFonts(title: "Area:", information: areaText, labelName: area)
        
        //        unwrapping currencies
        guard let cur = country?.currencies else {
            print("currencies were not loaded")
            return
        }
        var currencyText = ""

        for currency in cur {
            if let eur = currency.eur{
                if let name = eur.name, let symbol = eur.symbol {
                    currencyText += "\(name) (\(symbol))\n"
                }
            }
        }
        
        var curText = ""
        
        if cur.count > 1 {
            curText = "Currencies:"
        } else {
            curText = "Currency:"
        }
        properFonts(title: curText, information: currencyText, labelName: currency)
        
//        for i in 0..<curs.count {
//            if let cur = curs[i].eur{
//
//                currencyText += "\(cur) (\(cur.name!) (\(cur.symbol!)) \n "
//            }
//        }
    
        //        unwrapping timezones
        guard let timez = country?.timezones else {
            print("timezones were not loaded")
            return
        }
        
        var timezonesText = ""
        for i in 0..<timez.count {
            timezonesText += "\(timez[i]) \n "
        }
                
        var timeText = ""
        
        if timez.count > 1 {
            timeText = "Timezones:"

        } else {
            timeText = "Timezone:"
        }
        
        properFonts(title: timeText, information: timezonesText, labelName: timezones)

    }
    
//MARK: - Configuring
    func configureRegion(){
        region.numberOfLines = 2
        region.adjustsFontSizeToFitWidth = true
        region.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureCapital(){
        capital.numberOfLines = 0
        capital.adjustsFontSizeToFitWidth = true
        capital.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureCapitalCoordinates(){
        capitalCoordinates.numberOfLines = 0
        capitalCoordinates.adjustsFontSizeToFitWidth = true
        capitalCoordinates.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configurePopulation(){
        Population.numberOfLines = 0
        Population.adjustsFontSizeToFitWidth = true
        Population.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureArea(){
        area.numberOfLines = 0
        area.adjustsFontSizeToFitWidth = true
        area.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureCurrency(){
        currency.numberOfLines = 0
        currency.adjustsFontSizeToFitWidth = true
        currency.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureTimezones(){
        timezones.numberOfLines = 0
        timezones.adjustsFontSizeToFitWidth = true
        timezones.font = UIFont.systemFont(ofSize: 17)
    }
    
    func configureImageOfTheFlag(){
        imageOfTheFlag.layer.cornerRadius = 10
        imageOfTheFlag.clipsToBounds      = true
    }

    
//MARK: - Setting constraints
    func setimageOfTheFlagConstraint(){
        imageOfTheFlag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageOfTheFlag.topAnchor.constraint(equalTo: view.topAnchor, constant: 115),
            imageOfTheFlag.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageOfTheFlag.heightAnchor.constraint(equalToConstant: 193),
            imageOfTheFlag.widthAnchor.constraint(equalToConstant: 343),
        ])
    }
    
    func setregionConstraint(){
        region.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            region.topAnchor.constraint(equalTo: imageOfTheFlag.bottomAnchor, constant: 24),
            region.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    func setcapitalConstraint(){
        capital.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            capital.topAnchor.constraint(equalTo: region.bottomAnchor, constant: 24),
            capital.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    func setcapitalCoordinatesConstraint(){
        capitalCoordinates.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            capitalCoordinates.topAnchor.constraint(equalTo: capital.bottomAnchor, constant: 24),
            capitalCoordinates.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    func setPopultaionConstraint(){
        Population.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Population.topAnchor.constraint(equalTo: capitalCoordinates.bottomAnchor, constant: 24),
            Population.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    func setAreaConstraint(){
        area.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            area.topAnchor.constraint(equalTo: Population.bottomAnchor, constant: 24),
            area.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    func setCurrencyConstraint(){
        currency.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currency.topAnchor.constraint(equalTo: area.bottomAnchor, constant: 24),
            currency.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    func setTimezones(){
        timezones.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timezones.topAnchor.constraint(equalTo: currency.bottomAnchor, constant: 24),
            timezones.leadingAnchor.constraint(equalTo: imageOfTheFlag.leadingAnchor, constant: 8),
        ])
    }

    
    
//Downloading the image
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
    
// Inserting proper fonts
    func properFonts(title: String, information: String, labelName: UILabel){
        let attributedString = NSAttributedString(string: title, attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.boldSystemFont(ofSize: 15)
        ])

        let plainText = information

        // Create the attributed text for the first line
        let firstLine = NSMutableAttributedString()
        
        let dotSymbol: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10)
        ]
        let dotSymbolString = NSAttributedString(string: "\u{25CF}", attributes: dotSymbol)
        
        firstLine.append(dotSymbolString)
        firstLine.append(NSAttributedString(string: "   "))

        
        firstLine.append(attributedString)

        // Add a line break
        firstLine.append(NSAttributedString(string: "\n     "))

        // Append the plain text for the second line with a font size of 20
        let plainTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20)
        ]
        let plainTextAttributedString = NSAttributedString(string: plainText, attributes: plainTextAttributes)
        firstLine.append(plainTextAttributedString)

        // Set the attributed text to the UILabel
        labelName.attributedText = firstLine
    }

    func groupLargeNumber(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        numberFormatter.groupingSeparator = " "
        
        return numberFormatter.string(from: NSNumber(value: number)) ?? ""
    }

}


