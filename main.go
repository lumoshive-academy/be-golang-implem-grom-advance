package main

import (
	"session-28/cmd"
	"session-28/internal/data/repository"
	"session-28/internal/wire"
	"session-28/pkg/database"
	"session-28/pkg/utils"
)

func main() {

	config, err := utils.ReadConfiguration()
	if err != nil {
		// print error
	}

	db, err := database.InitDB(config.DB)
	if err != nil {
		// print err
	}

	repo := repository.NewRepository(db)
	route := wire.Wiring(*repo)
	cmd.APiserver(route)
}
