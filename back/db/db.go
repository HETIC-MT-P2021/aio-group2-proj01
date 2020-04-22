package db

import (
	"database/sql"
	"fmt"
	"github.com/spf13/viper"
	"os"
	"time"

	_ "github.com/lib/pq"
)

var (
	DB *sql.DB
)

func GetPostgresConnection() string {
	host := viper.Get("DB_HOST")
	username := viper.Get("DB_USER")
	password := viper.Get("DB_PASSWORD")
	dbName := viper.Get("DB_NAME")
	port := os.Getenv("DB_PORT")
	appName := os.Getenv("APP_NAME")

	pqConnection := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable&application_name=%s", username, password, host, port, dbName, appName)

	return pqConnection
}

// GetPostgresDB - get postgres db config connection
func Connect() {
	var err error
	pqConnection := GetPostgresConnection()

	DB, err = sql.Open("postgres", pqConnection)
	if err != nil {
		panic(err)
	}

	err = PingDB()
	if err != nil {
		panic(err)
	}

	DB.SetConnMaxLifetime(time.Duration(10) * time.Second)
	DB.SetMaxIdleConns(5)
	DB.SetMaxOpenConns(2)

}

func PingDB() error {
	err := DB.Ping()
	if err != nil {
		return err
	}
	return nil
}
