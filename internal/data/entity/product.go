package entity

type Product struct {
	Model
	Name string `gorm:"type:varchar(100);not null" json:"name" validate:"reqired"`
}

func SeedProducts() []Product {
	products := []Product{
		{
			Name: "sepatu",
		},
		{
			Name: "sandal",
		},
		{
			Name: "baju",
		},
	}

	return products
}
