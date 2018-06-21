@testable import TestProject

class AnotherDeclarationInTheFileShouldNotBeAffected {
    
    func shouldNotInterfere() {
        
    }
}

<caret>class SimpleProtoco<caret>lMock: <caret>SimpleProtocol {<caret>
<caret>    <caret>var anOldMock<caret> = false<caret>
<caret>    <caret>func anOldMockMet<caret>hod() {<caret>
<caret>        <caret>anOldMock<caret> = true<caret>
       <caret> class Inner {

        }<caret>
<caret>    <caret>}<caret>
<caret>}
