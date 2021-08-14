package main

import (
	"log"
	"os"

	"${MODULE}"
	"${MODULE}/internal/bot"
	"${MODULE}/internal/database"
)

func main() {
	db, err := database.Open(os.Getenv("DB_URL"))
	if err != nil {
		log.Fatal(err)
	}

	boot := ${PROJECT}.Bootstrap{
		DB: db,
	}

	b, err := bot.New("bot.yml", boot)
	if err != nil {
		log.Fatal(err)
	}

	b.Start()
}