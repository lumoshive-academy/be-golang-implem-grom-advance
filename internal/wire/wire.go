package wire

import (
	"session-28/internal/adaptor"
	"session-28/internal/data/repository"
	"session-28/internal/usecase"
	"session-28/pkg/middleware"

	"github.com/go-chi/chi/v5"
)

func Wiring(repo repository.Repository) *chi.Mux {
	router := chi.NewRouter()
	rV1 := chi.NewRouter()
	wireUser(rV1, repo)
	wireTours(rV1, repo)
	router.Mount("/api/v1", rV1)

	return router
}

func wireUser(router *chi.Mux, repo repository.Repository) {
	usecaseUser := usecase.NewUserUseCase(repo)
	adaptorUser := adaptor.NewUserAdaptor(usecaseUser)
	router.With(middleware.Auth).Get("/users", adaptorUser.Get)
}

func wireTours(router *chi.Mux, repo repository.Repository) {
	usecaseTour := usecase.NewTourService(repo)
	adaptorTour := adaptor.NewTourAdaptor(usecaseTour)
	router.Get("/tours", adaptorTour.GetAllTours)
}
