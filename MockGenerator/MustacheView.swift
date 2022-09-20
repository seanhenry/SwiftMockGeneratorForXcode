import UseCases
import GRMustache
import Foundation
import AST

class MustacheView: NSObject, MockView {

    typealias ModelDictionary = [String: Any]
    
    private(set) var result = ""
    private let templateName: String
    private let element: AST.TypeDeclaration

    init(templateName: String, element: AST.TypeDeclaration) {
        self.templateName = templateName
        self.element = element
    }

    func render(model: MockViewModel) {
        do {
            let template = try GRMustacheTemplate(fromResource: templateName, bundle: Bundle(for: MustacheView.self))
            let dict = injectAdditionalValues(model.toDictionary() as! ModelDictionary)
            result = try template.renderObject(dict)
        } catch { } // ignored
    }
    
    private func injectAdditionalValues(_ dict: ModelDictionary) -> ModelDictionary {
        let scope: String? = {
            if element.hasOpenModifier {
                return "open"
            } else if element.hasPublicModifier {
                return "public"
            } else if element.hasInternalModifier {
                return "internal"
            } else if element.hasPrivateModifier || element.hasFilePrivateModifier {
                return "fileprivate"
            } else {
                return nil
            }
        }()
        
        var result = dict
        result["scope"] = scope
        
        let initializers = (dict["initializer"] as? [Any]) ?? []
        
        if (scope == "open" || scope == "public") && initializers.isEmpty {
            result["publicInitializer"] = NSNumber(true)
        }
            
        return result
    }
}

extension MockViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["initializer"] = initializer.map { $0.toDictionary() }
        dictionary["property"] = property.map { $0.toDictionary() }
        dictionary["method"] = method.map { $0.toDictionary() }
        dictionary["subscript"] = `subscript`.map { $0.toDictionary() }
        return dictionary
    }
}

extension InitializerViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["declarationText"] = declarationText
        dictionary["initializerCall"] = initializerCall
        return dictionary
    }
}

extension PropertyViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["name"] = name
        dictionary["capitalizedUniqueName"] = capitalizedUniqueName
        dictionary["hasSetter"] = hasSetter
        dictionary["type"] = type
        dictionary["optionalType"] = optionalType
        dictionary["iuoType"] = iuoType
        dictionary["defaultValueAssignment"] = defaultValueAssignment
        if let defaultValue = defaultValue {
            dictionary["defaultValue"] = defaultValue
        }
        dictionary["isImplemented"] = isImplemented
        dictionary["declarationText"] = declarationText
        return dictionary
    }
}

extension MethodViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["capitalizedUniqueName"] = capitalizedUniqueName
        dictionary["closureParameter"] = closureParameter.map { $0.toDictionary() }
        if let escapingParameters = escapingParameters {
            dictionary["escapingParameters"] = escapingParameters.toDictionary()
        }
        if let resultType = resultType {
            dictionary["resultType"] = resultType.toDictionary()
        }
        if let functionCall = functionCall {
            dictionary["functionCall"] = functionCall
        }
        dictionary["throws"] = `throws`
        dictionary["rethrows"] = `rethrows`
        dictionary["isImplemented"] = isImplemented
        dictionary["declarationText"] = declarationText
        return dictionary
    }
}

extension ClosureParameterViewModel {

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

extension ParametersViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["tupleAssignment"] = tupleAssignment
        dictionary["tupleRepresentation"] = tupleRepresentation
        return dictionary
    }
}

extension ResultTypeViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["defaultValueAssignment"] = defaultValueAssignment
        if let defaultValue = defaultValue {
            dictionary["defaultValue"] = defaultValue
        }
        dictionary["optionalType"] = optionalType
        dictionary["iuoType"] = iuoType
        dictionary["type"] = type
        dictionary["returnCastStatement"] = returnCastStatement
        return dictionary
    }
}

extension SubscriptViewModel {

    fileprivate func toDictionary() -> NSDictionary {
        let dictionary = NSMutableDictionary()
        dictionary["capitalizedUniqueName"] = capitalizedUniqueName
        if let escapingParameters = escapingParameters {
            dictionary["escapingParameters"] = escapingParameters.toDictionary()
        }
        dictionary["hasSetter"] = hasSetter
        dictionary["resultType"] = resultType.toDictionary()
        if let functionCall = functionCall {
            dictionary["functionCall"] = functionCall
        }
        dictionary["isImplemented"] = isImplemented
        dictionary["declarationText"] = declarationText
        return dictionary
    }
}
