
# Makefile for Mumi iOS App

# Variables
PROJECT = Mumi.xcodeproj
SCHEME = Mumi
DESTINATION = 'platform=iOS Simulator,name=iPhone 16 Pro'

# Targets
.PHONY: all build test lint

all: build

build:
	xcodebuild build -project $(PROJECT) -scheme $(SCHEME) -destination $(DESTINATION)

test:
	xcodebuild test -project $(PROJECT) -scheme $(SCHEME) -destination $(DESTINATION)

lint:
	swiftlint

