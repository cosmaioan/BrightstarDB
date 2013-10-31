#!/bin/bash

CONFIGURATION=Debug
MONO_DIR=mono
CURRENT_DIR=`pwd`
LIB_DIR="$CURRENT_DIR"/build
export MSBuildExtensionsPath="$CURRENT_DIR"/xbuild

if [ -d "$LIB_DIR" ]
then
    rm -rf "$LIB_DIR"
fi
mkdir "$LIB_DIR"
mkdir "$LIB_DIR"/service

function buildComponent {
	xbuild /p:Configuration="$CONFIGURATION" ../src/"$1"/"$2"/"$2".csproj
	cp ../src/"$1"/"$2"/bin/"$CONFIGURATION"/"$2".dll "$LIB_DIR"
}

function build {
    xbuild /p:Configuration="$CONFIGURATION" ../src/"$1"/"$2"/"$2".csproj
}

# Build core components
buildComponent core BrightstarDB
buildComponent core BrightstarDB.Server.Modules
build core BrightstarDB.Server.Runner
cp -r ../src/core/BrightstarDB.Server.Runner/bin/"$CONFIGURATION"/* "$LIB_DIR"/service

# Build Tests
#build core BrightstarDB.Tests
#build core BrightstarDB.EntityFramework.Tests
#build core BrightstardB.InternalTests
#build core BrightstarDB.Server.Modules.Tests
#build core BrightstarDB.Server.IntegrationTests

