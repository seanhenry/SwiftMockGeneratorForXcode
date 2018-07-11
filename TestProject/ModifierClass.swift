class ModifierClass {
  class func a() {}
  @objc dynamic var b: Int = 0
  lazy var c: Int = 0
  unowned var d: NSObject = NSObject()
  unowned(safe) var e: NSObject = NSObject()
  unowned(unsafe) var f: NSObject = NSObject()
  weak var g: NSObject?
  convenience init(a: String) {
    self.init(b: "")
  }
  required init(b: String) {}
}
