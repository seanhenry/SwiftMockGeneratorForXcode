@testable import TestProject

class ModifierClassMock: ModifierClass {
    convenience init() {
        self.init(a: "")
    }
    var invokedBSetter = false
    var invokedBSetterCount = 0
    var invokedB: Int?
    var invokedBList = [Int]()
    var invokedBGetter = false
    var invokedBGetterCount = 0
    var stubbedB: Int! = 0
    override var b: Int {
        set {
            invokedBSetter = true
            invokedBSetterCount += 1
            invokedB = newValue
            invokedBList.append(newValue)
        }
        get {
            invokedBGetter = true
            invokedBGetterCount += 1
            return stubbedB
        }
    }
    var invokedCSetter = false
    var invokedCSetterCount = 0
    var invokedC: Int?
    var invokedCList = [Int]()
    var invokedCGetter = false
    var invokedCGetterCount = 0
    var stubbedC: Int! = 0
    override var c: Int {
        set {
            invokedCSetter = true
            invokedCSetterCount += 1
            invokedC = newValue
            invokedCList.append(newValue)
        }
        get {
            invokedCGetter = true
            invokedCGetterCount += 1
            return stubbedC
        }
    }
    var invokedDSetter = false
    var invokedDSetterCount = 0
    var invokedD: NSObject?
    var invokedDList = [NSObject]()
    var invokedDGetter = false
    var invokedDGetterCount = 0
    var stubbedD: NSObject!
    override var d: NSObject {
        set {
            invokedDSetter = true
            invokedDSetterCount += 1
            invokedD = newValue
            invokedDList.append(newValue)
        }
        get {
            invokedDGetter = true
            invokedDGetterCount += 1
            return stubbedD
        }
    }
    var invokedESetter = false
    var invokedESetterCount = 0
    var invokedE: NSObject?
    var invokedEList = [NSObject]()
    var invokedEGetter = false
    var invokedEGetterCount = 0
    var stubbedE: NSObject!
    override var e: NSObject {
        set {
            invokedESetter = true
            invokedESetterCount += 1
            invokedE = newValue
            invokedEList.append(newValue)
        }
        get {
            invokedEGetter = true
            invokedEGetterCount += 1
            return stubbedE
        }
    }
    var invokedFSetter = false
    var invokedFSetterCount = 0
    var invokedF: NSObject?
    var invokedFList = [NSObject]()
    var invokedFGetter = false
    var invokedFGetterCount = 0
    var stubbedF: NSObject!
    override var f: NSObject {
        set {
            invokedFSetter = true
            invokedFSetterCount += 1
            invokedF = newValue
            invokedFList.append(newValue)
        }
        get {
            invokedFGetter = true
            invokedFGetterCount += 1
            return stubbedF
        }
    }
    var invokedGSetter = false
    var invokedGSetterCount = 0
    var invokedG: NSObject?
    var invokedGList = [NSObject?]()
    var invokedGGetter = false
    var invokedGGetterCount = 0
    var stubbedG: NSObject!
    override var g: NSObject? {
        set {
            invokedGSetter = true
            invokedGSetterCount += 1
            invokedG = newValue
            invokedGList.append(newValue)
        }
        get {
            invokedGGetter = true
            invokedGGetterCount += 1
            return stubbedG
        }
    }
}
