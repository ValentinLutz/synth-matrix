package main

import (
	"root/libraries/mageutil"
)

type BuildProps struct {
	OperatingSystem string
	Architecture    string
}

func getOrSetDefaultBuildEnvVars() *BuildProps {
	mageutil.GetValueOrSetDefault("CGO_ENABLED", "0")

	return &BuildProps{
		OperatingSystem: mageutil.GetValueOrSetDefault("GOOS", "linux"),
		Architecture:    mageutil.GetValueOrSetDefault("GOARCH", "arm64"),
	}
}
