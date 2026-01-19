package repository

import (
	"context"
	"session-28/internal/data/entity"
	"session-28/internal/dto"
	"strings"

	"gorm.io/gorm"
)

type TourRepository interface {
	FindAll(ctx context.Context, f dto.TourFilterRequest) ([]entity.Tour, int64, error)
}

type tourRepository struct {
	db *gorm.DB
}

func NewTourRepository(db *gorm.DB) TourRepository {
	return &tourRepository{db}
}

func (r *tourRepository) FindAll(ctx context.Context, f dto.TourFilterRequest) ([]entity.Tour, int64, error) {
	var tours []entity.Tour
	var totalItems int64

	query := r.db.Model(&entity.Tour{}).
		Preload("Location").
		Preload("Images", "is_main = ?", true).
		Preload("Reviews")

	query = query.Preload("Schedules", func(db *gorm.DB) *gorm.DB {
		return db.Where("start_date >= CURRENT_DATE").Order("start_date asc").Limit(1)
	})

	if f.Search != "" {
		searchPattern := "%" + strings.ToLower(f.Search) + "%"
		query = query.Joins("JOIN locations l ON l.id = tours.location_id").
			Where("LOWER(tours.name) LIKE ?",
				searchPattern)
	}

	if f.Date != "" {
		query = query.Joins("JOIN tour_schedules ts ON ts.tour_id = tours.id").
			Where("ts.start_date >= ?", f.Date).
			Group("tours.id")
	}

	if err := query.Count(&totalItems).Error; err != nil {
		return nil, 0, err
	}

	switch f.SortBy {
	case "price_low":
		query = query.Order("tours.base_price asc")
	case "price_high":
		query = query.Order("tours.base_price desc")
	default:
		query = query.Order("tours.created_at desc")
	}

	offset := (f.Page - 1) * f.Limit

	err := query.Limit(f.Limit).Offset(offset).Find(&tours).Error

	return tours, totalItems, err
}
