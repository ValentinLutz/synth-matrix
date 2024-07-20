package incoming

import (
	"context"
	"log/slog"
	"root/libraries/apputil"
	"strconv"
	"time"
)

//go:generate go run github.com/jkrajniak/graphql-codegen-go@v1.2.1 -schemas ../../api-definition/schema.graphql -packageName incoming -out models.gen.go -entities Person,PersonInput

type Handler struct {
}

func NewHandler() (*Handler, error) {
	apputil.NewSlogDefault(slog.LevelInfo)

	return &Handler{}, nil
}

func (handler *Handler) Invoke(_ context.Context, event Event) (Person, error) {
	seed := time.Now().UnixMilli()
	if event.Arguments.PersonInput.Seed != nil {
		parsedSeed, err := strconv.ParseInt(*event.Arguments.PersonInput.Seed, 10, 64)
		if err != nil {
			slog.Error("failed to parse seed", apputil.ErrorAttr(err), slog.Any("seed", *event.Arguments.PersonInput.Seed))
			return Person{}, err
		}
		seed = parsedSeed
	}

	return Person{
		Seed:      strconv.FormatInt(seed, 10),
		FirstName: "rani",
		LastName:  "blue",
		Email:     "bubble@example.com",
		Phone:     "123-456-7890",
	}, nil
}

type Event struct {
	Arguments Arguments `json:"arguments"`
}

type Arguments struct {
	PersonInput PersonInput `json:"personInput"`
}
