package usecase

import (
	"context"
	"session-28/internal/data/repository"
	"session-28/internal/dto"
)

type UserUseCaseInterface interface {
	GetUser(ctx context.Context) (dto.ResponseUser, error)
}

type UserUseCase struct {
	UserRepo repository.Repository
}

func NewUserUseCase(userRepo repository.Repository) UserUseCaseInterface {
	return &UserUseCase{UserRepo: userRepo}
}

func (userUseCase *UserUseCase) GetUser(ctx context.Context) (dto.ResponseUser, error) {
	users, err := userUseCase.UserRepo.UserRepo.GetUser(ctx)
	if err != nil {
		return users, err
	}

	return users, nil
}
