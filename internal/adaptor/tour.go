package adaptor

import (
	"net/http"
	"session-28/internal/dto"
	"session-28/internal/usecase"
	"session-28/pkg/utils"
)

type TourHandler struct {
	service usecase.TourService
}

func NewTourAdaptor(service usecase.TourService) *TourHandler {
	return &TourHandler{service}
}

// GetAllTours menangani GET /tours
func (h *TourHandler) GetAllTours(w http.ResponseWriter, r *http.Request) {

	ctx := r.Context()

	date := r.URL.Query().Get("date")
	search := r.URL.Query().Get("search")
	sortBy := r.URL.Query().Get("sort_by")

	// Construct DTO
	req := dto.TourFilterRequest{
		Date:   date,
		Search: search,
		SortBy: sortBy,
	}

	result, pagination, err := h.service.GetListTours(ctx, req)
	if err != nil {
		utils.ResponseBadRequest(w, http.StatusBadGateway, "", nil)
		return
	}

	utils.ResponsePagination(w, http.StatusOK, "success get data", result, pagination)
}
