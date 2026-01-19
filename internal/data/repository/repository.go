package repository

import (
	"gorm.io/gorm"
)

type Repository struct {
	UserRepo UserRepoInterface
	TourRepo TourRepository
}

func NewRepository(db *gorm.DB) *Repository {
	return &Repository{
		UserRepo: NewUserRepo(db),
		TourRepo: NewTourRepository(db),
	}
}
