
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
	xcodebuild test -workspace $(WORKSPACE) -scheme $(SCHEME) -destination $(DESTINATION)

lint:
	swiftlint

