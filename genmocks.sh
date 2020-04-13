#!/bin/bash -e
genmock . \
	--target-name IO \
	--target-name Resolver \
	--out-dir MockGeneratorTests \
	--mock-postfix Spy \
	--import SwiftyKit \
	--import AST \
	--import Foundation \
	--testable-import MockGenerator