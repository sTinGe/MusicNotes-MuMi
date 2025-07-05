
# Makefile for Mumi iOS App

# Variables
WORKSPACE = Mumi.xcworkspace
SCHEME = Mumi
DESTINATION = 'platform=iOS Simulator,name=iPhone 16 Pro'

# Targets
.PHONY: all build test lint

all: build

build:
	xcodebuild build -workspace $(WORKSPACE) -scheme $(SCHEME) -destination $(DESTINATION)

test:
	make test-unit
	make test-ui

test-unit:
	xcodebuild test -workspace $(WORKSPACE) -scheme $(SCHEME) -destination $(DESTINATION) -skip-testing:MumiUITests

test-ui:
	xcodebuild test -workspace $(WORKSPACE) -scheme $(SCHEME) -destination $(DESTINATION) -only-testing:MumiUITests

lint:
	swift package plugin --allow-writing-to-package-directory swiftlint
