package mageutil

import (
	"fmt"
	"os"
)

func GetValueOrSetDefault(key string, defaultValue string) string {
	value, ok := os.LookupEnv(key)
	if !ok {
		fmt.Printf("env '%s' not set, defaulting to '%s'\n", key, defaultValue)

		err := os.Setenv(key, defaultValue)
		if err != nil {
			panic(fmt.Errorf("failed to set env: %w", err))
		}

		return defaultValue
	}
	return value
}

func GetEnvValueOrWaitForInput(key string, defaultValue string) string {
	value, ok := os.LookupEnv(key)
	if !ok {
		fmt.Printf("%s [%s]: ", key, defaultValue)

		var inputValue string
		_, err := fmt.Scanln(&inputValue)
		if err != nil {
			inputValue = defaultValue
		}

		err = os.Setenv(key, inputValue)
		if err != nil {
			panic(fmt.Errorf("failed to set env: %w", err))
		}

		return inputValue
	}

	return value
}
