package entity

import "gorm.io/gorm"

type Category struct {
	gorm.Model
	Name  string  `gorm:"type:varchar(50);unique;not null" json:"name"`
	Tours []*Tour `gorm:"many2many:tour_categories;" json:"tours,omitempty"`
}
