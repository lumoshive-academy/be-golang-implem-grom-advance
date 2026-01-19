package entity

import "gorm.io/gorm"

type Location struct {
	gorm.Model
	City      string `gorm:"type:varchar(100);not null" json:"city"`
	Country   string `gorm:"type:varchar(100);not null" json:"country"`
	Continent string `gorm:"type:varchar(50)" json:"continent"`
	Tours     []Tour `gorm:"foreignKey:LocationID" json:"tours,omitempty"`
}
