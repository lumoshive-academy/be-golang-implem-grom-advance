package database

import (
	"fmt"
	"log"
	"os"
	"session-28/pkg/utils"

	"time"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func InitDB(config utils.DatabaseCofig) (*gorm.DB, error) {
	connStr := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable host=%s",
		config.Username, config.Password, config.Name, config.Host)

	// Setup logger for GORM
	newLogger := logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags), // io writer
		logger.Config{
			SlowThreshold:             time.Second, // Slow SQL threshold
			LogLevel:                  logger.Info, // Log level
			IgnoreRecordNotFoundError: false,       // Ignore ErrRecordNotFound error for logger
			Colorful:                  true,        // Disable color
		},
	)

	conn, err := gorm.Open(postgres.Open(connStr), &gorm.Config{
		Logger:      newLogger,
		PrepareStmt: true,
	})

	if err != nil {
		return nil, fmt.Errorf("parse config: %w", err)
	}

	sqlDB, _ := conn.DB()

	// ---- Pool settings ----
	sqlDB.SetConnMaxIdleTime(time.Duration(config.MaxConn) * time.Minute)
	sqlDB.SetConnMaxLifetime(time.Duration(config.MaxConn) * time.Minute)
	sqlDB.SetMaxIdleConns(20)
	sqlDB.SetMaxOpenConns(20)

	return conn, nil
}
