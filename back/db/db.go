package db

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq" // Go Postgres driver
	"github.com/spf13/viper"
)

var (
	DB *sql.DB
)

// GetPostgresDataSourceName returns environment variable for database connection.
func GetPostgresDataSourceName() string {
	return fmt.Sprintf(
		"postgres://%s:%s@%s:%s/%s?sslmode=disable&application_name=%s",
		viper.GetString("DB_USER"),
		viper.GetString("DB_PASSWORD"),
		viper.GetString("DB_HOST"),
		viper.GetString("DB_PORT"),
		viper.GetString("DB_NAME"),
		viper.GetString("APP_NAME"),
	)
}

// Connect connect to the database.
func Connect() {
	var err error

	dsn := GetPostgresDataSourceName()

	DB, err = sql.Open("postgres", dsn)
	if err != nil {
		panic(err)
	}

	if err := DB.Ping(); err != nil {
		panic(err)
	}
}
