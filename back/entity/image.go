package entity

type Image struct {
	ID          int    `json:"id_image"`
	Description string `json:"description"`
	IDCategory  string `json:"id_category"`
	URL  string `json:"url"`
	CreatedAt   string `json:"created_at"`
}
