<caret>@testable import TestProject<caret>

<caret>class AnotherDeclarationInTheFileShouldNotBeAffected<caret> {

<caret>func shouldNotInterfere() {
        <caret>
    }<caret>
<caret>}<caret>
<caret>
class SimpleProtocolMock: SimpleProtocol {
    var anOldMock = false
    func anOldMockMethod() {
        anOldMock = true
        <caret>class Inner<caret> {
        <caret>func inner<caret>() {<caret>}<caret>
        <caret>}
    }
}<caret>
<caret>
