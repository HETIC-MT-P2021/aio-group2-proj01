package entity

type Image struct {
	ID          int    `json:"id_image"`
	Description string `json:"description"`
	IDCategory  string `json:"id_category"`
	AddedDate   string `json:"added_date"`
}
