@objc(XPCBufferInstructions) class XPCBufferInstructions: NSObject, NSSecureCoding {
    var deleteIndex: Int
    var deleteLength: Int
    var insertIndex: Int
    var linesToInsert: [String]

    init(deleteIndex: Int,
         deleteLength: Int,
         insertIndex: Int,
         linesToInsert: [String]) {
        self.deleteIndex = deleteIndex
        self.deleteLength = deleteLength
        self.insertIndex = insertIndex
        self.linesToInsert = linesToInsert
    }

    static var supportsSecureCoding: Bool {
        return true
    }

    required init?(coder aDecoder: NSCoder) {
        guard let linesToInsert = aDecoder.decodeObject(of: [NSArray.self, NSString.self], forKey: "linesToInsert") as? [String],
              let deleteIndex = aDecoder.decodeObject(of: NSNumber.self, forKey: "deleteIndex") as? NSNumber,
              let deleteLength = aDecoder.decodeObject(of: NSNumber.self, forKey: "deleteLength") as? NSNumber,
              let insertIndex = aDecoder.decodeObject(of: NSNumber.self, forKey: "insertIndex") as? NSNumber else {
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
