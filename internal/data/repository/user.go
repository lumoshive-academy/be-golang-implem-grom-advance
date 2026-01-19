package repository

import (
	"context"
	"session-28/internal/data/entity"
	"session-28/internal/dto"

	"gorm.io/gorm"
)

type UserRepoInterface interface {
	GetUser(ctx context.Context) (dto.ResponseUser, error)
}

type UserRepo struct {
	DB *gorm.DB
}

func NewUserRepo(db *gorm.DB) UserRepoInterface {
	return &UserRepo{DB: db}
}

func (userRepo *UserRepo) GetUser(ctx context.Context) (dto.ResponseUser, error) {
	// query := `SELECT name, email FROM users WHERE id = 1 AND pg_sleep(10) IS NULL`

	// reqID := ctx.Value("ctxid").(string)
	// fmt.Println(reqID)

	var user entity.User
	var userResult dto.ResponseUser
	// err := userRepo.DB.WithContext(ctx).Raw(query).Scan(&user).Error
	err := userRepo.DB.WithContext(ctx).First(&user, 1).Error
	if err != nil {
		return userResult, err
	}

	userResult = dto.ResponseUser{
		Name:  user.Name,
		Email: user.Email,
	}

	return userResult, nil
}
