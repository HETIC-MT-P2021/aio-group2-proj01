package entity

// Category defines the structure of the category entity
type Category struct {
	ID          int    `json:"id_category"`
	Name        string `json:"name"`
	Description string `json:"description"`
}
