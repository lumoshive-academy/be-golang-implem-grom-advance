package entity

import (
	"time"

	"gorm.io/gorm"
)

type TourSchedule struct {
	gorm.Model
	TourID        uint      `gorm:"not null" json:"tour_id"`
	StartDate     time.Time `gorm:"type:date;not null" json:"start_date"`
	EndDate       time.Time `gorm:"type:date;not null" json:"end_date"`
	PriceOverride float64   `gorm:"type:decimal(10,2)" json:"price_override"` // Harga khusus tanggal ini
	Quota         int       `gorm:"default:30" json:"quota"`
	BookedCount   int       `gorm:"default:0" json:"booked_count"`
	Status        string    `gorm:"type:varchar(20);default:'open'" json:"status"` // open, closed, sold_out

	// Relasi
	Tour     Tour      `gorm:"foreignKey:TourID" json:"tour,omitempty"` // Belongs To
	Bookings []Booking `gorm:"foreignKey:TourScheduleID" json:"bookings,omitempty"`
}
