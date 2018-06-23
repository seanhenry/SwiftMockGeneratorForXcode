@objc(XPCBufferInstructions) class XPCBufferInstructions: NSObject, NSSecureCoding {

    var deleteIndex: Int
    var deleteLength: Int
    var insertIndex: Int
    var linesToInsert: [String]

    static var supportsSecureCoding: Bool {
        return true
    }

    init(deleteIndex: Int,
         deleteLength: Int,
         insertIndex: Int,
         linesToInsert: [String]) {
        self.deleteIndex = deleteIndex
        self.deleteLength = deleteLength
        self.insertIndex = insertIndex
        self.linesToInsert = linesToInsert
    }

    required init?(coder aDecoder: NSCoder) {
        guard let linesToInsert = aDecoder.decodeObject(of: [NSArray.self, NSString.self], forKey: "linesToInsert") as? [String],
              let deleteIndex = aDecoder.decodeObject(of: NSNumber.self, forKey: "deleteIndex"),
              let deleteLength = aDecoder.decodeObject(of: NSNumber.self, forKey: "deleteLength"),
              let insertIndex = aDecoder.decodeObject(of: NSNumber.self, forKey: "insertIndex") else {
            return nil
        }
        self.deleteIndex = deleteIndex.intValue
        self.deleteLength = deleteLength.intValue
        self.insertIndex = insertIndex.intValue
        self.linesToInsert = linesToInsert
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(deleteIndex, forKey: "deleteIndex")
        aCoder.encode(deleteLength, forKey: "deleteLength")
        aCoder.encode(insertIndex, forKey: "insertIndex")
        aCoder.encode(linesToInsert as NSArray, forKey: "linesToInsert")
    }
}
