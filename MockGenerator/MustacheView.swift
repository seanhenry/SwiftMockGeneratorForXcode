import UseCases
import GRMustache
import Foundation

class MustacheView: NSObject, UseCasesMockView {

    private(set) var result = ""

    func render(model: UseCasesMockViewModel) {
        do {
            let template = try GRMustacheTemplate(fromResource: "mock", bundle: Bundle(for: MustacheView.self))
            result = try template.renderObject(model.toDictionary())
        } catch { } // ignored
    }
}

extension UseCasesMockViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["initializer"] = initializer.map { $0.toDictionary() }
        dictionary["property"] = property.map { $0.toDictionary() }
        dictionary["method"] = method.map { $0.toDictionary() }
        return dictionary
    }
}

extension UseCasesInitializerViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["declarationText"] = declarationText
        dictionary["initializerCall"] = initializerCall
        return dictionary
    }
}

extension UseCasesPropertyViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["optionalType"] = optionalType
        dictionary["iuoType"] = iuoType
        dictionary["defaultValueAssignment"] = defaultValueAssignment
        dictionary["declarationText"] = declarationText
        dictionary["type"] = type
        dictionary["capitalizedUniqueName"] = capitalizedUniqueName
        dictionary["hasSetter"] = hasSetter
        return dictionary
    }
}

extension UseCasesMethodViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["capitalizedUniqueName"] = capitalizedUniqueName
        dictionary["closureParameter"] = closureParameter.map { $0.toDictionary() }
        dictionary["declarationText"] = declarationText
        if let escapingParameters = escapingParameters {
            dictionary["escapingParameters"] = escapingParameters.toDictionary()
        }
        dictionary["throws"] = `throws`
        if let resultType = resultType {
            dictionary["resultType"] = resultType.toDictionary()
        }
        return dictionary
    }
}

extension UseCasesClosureParameterViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["name"] = name
        dictionary["argumentsTupleRepresentation"] = argumentsTupleRepresentation
        dictionary["capitalizedName"] = capitalizedName
        dictionary["hasArguments"] = hasArguments
        dictionary["implicitClosureCall"] = implicitClosureCall
        return dictionary
    }
}

extension UseCasesParametersViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["tupleAssignment"] = tupleAssignment
        dictionary["tupleRepresentation"] = tupleRepresentation
        return dictionary
    }
}

extension UseCasesResultTypeViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["defaultValueAssignment"] = defaultValueAssignment
        dictionary["iuoType"] = iuoType
        dictionary["optionalType"] = optionalType
        dictionary["returnCastStatement"] = returnCastStatement
        return dictionary
    }
}
