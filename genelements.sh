#!/bin/bash
sourcery --config sourcery/generate-elements.sourcery.yml
cp -f sourcery/out/ElementImplementations.generated.swift SwiftStructureInterface/structure/model/impl
cp -f sourcery/out/ElementProxies.generated.swift SwiftStructureInterface/structure/model/impl
cp -f sourcery/out/ElementVisitor.generated.swift SwiftStructureInterface/structure/visitor
cp -f sourcery/out/EmptyElements.generated.swift SwiftStructureInterface/structure/model/impl
