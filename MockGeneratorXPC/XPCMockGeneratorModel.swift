import Foundation

@objc(XPCMockGeneratorModel) class XPCMockGeneratorModel: NSObject, NSSecureCoding {

    let contents: String
    let projectURL: URL
    let line: Int
    let column: Int
    let templateName: String

    static var supportsSecureCoding: Bool {
        return true
    }

    init(contents: String,
         projectURL: URL,
         line: Int,
         column: Int,
         templateName: String) {
        self.contents = contents
        self.projectURL = projectURL
        self.line = line
        self.column = column
        self.templateName = templateName
    }

    required init?(coder aDecoder: NSCoder) {
        guard let contents = aDecoder.decodeObject(of: NSString.self, forKey: "contents"),
              let projectURL = aDecoder.decodeObject(of: NSURL.self, forKey: "projectURL"),
              let line = aDecoder.decodeObject(of: NSNumber.self, forKey: "line"),
              let column = aDecoder.decodeObject(of: NSNumber.self, forKey: "column"),
              let templateName = aDecoder.decodeObject(of: NSString.self, forKey: "templateName") else {
            return nil
        }
        self.contents = contents as String
        self.projectURL = projectURL as URL
        self.line = line.intValue
        self.column = column.intValue
        self.templateName = templateName as String
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(contents as NSString, forKey: "contents")
        aCoder.encode(projectURL as NSURL, forKey: "projectURL")
        aCoder.encode(line as NSNumber, forKey: "line")
        aCoder.encode(column as NSNumber, forKey: "column")
        aCoder.encode(templateName as NSString, forKey: "templateName")
    }
}
