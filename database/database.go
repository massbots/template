package database

import (
	"database/sql"

	_ "${SQL_DRIVER}"
)

type DB struct {
	*sql.DB
}

func Open(url string) (*DB, error) {
	db, err := sql.Open("${SQL_DIALECT}", url)
	if err != nil {
		return nil, err
	}
	return &DB{DB: db}, nil
}