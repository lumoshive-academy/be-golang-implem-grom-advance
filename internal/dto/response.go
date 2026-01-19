package dto

type ResponseUser struct {
	Name  string `json:"name"`
	Email string `json:"email"`
}

type Pagination struct {
	CurrentPage  int   `json:"current_page"`
	Limit        int   `json:"limit"`
	TotalPages   int   `json:"total_pages"`
	TotalRecords int64 `json:"total_records"`
}

type TourResponse struct {
	ID            uint    `json:"id"`
	Name          string  `json:"name"`
	Location      string  `json:"location"`
	ImageURL      string  `json:"image_url"`
	Price         float64 `json:"price"`
	Duration      int     `json:"duration_day"`
	Rating        float64 `json:"rating"`
	ReviewCount   int     `json:"review_count"`
	RemainingSeat int     `json:"remaining_seat"`
}
