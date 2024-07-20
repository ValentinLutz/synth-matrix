package main

import (
	"github.com/aws/aws-lambda-go/lambda"
	"root/lambda-v1-get-person/incoming"
)

func main() {
	handler, err := incoming.NewHandler()
	if err != nil {
		panic(err)
	}
	lambda.Start(handler.Invoke)
}
