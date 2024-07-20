package apputil

import (
	"log/slog"
	"os"
)

func NewSlogDefault(level slog.Level) {
	handler := slog.NewJSONHandler(
		os.Stdout, &slog.HandlerOptions{
			AddSource: true,
			Level:     level,
		},
	)
	logger := slog.New(handler)
	slog.SetDefault(logger)
}

func ErrorAttr(value error) slog.Attr {
	return slog.Any("err", value)
}
