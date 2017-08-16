protocol Element {
    var name: String { get } // name
//    var kind: String { get } // kind
//    var file: File? { get }
//    var scope: String? { get } // accessibility
//    var parent: Element? { get }
    var children: [Element] { get }
}
