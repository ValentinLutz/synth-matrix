// Code generated by go generate; DO NOT EDIT.
// This file was generated from GraphQL schema

package incoming

type Person struct {
	Seed      string `json:"seed"`
	FirstName string `json:"firstName"`
	LastName  string `json:"lastName"`
	Email     string `json:"email"`
	Phone     string `json:"phone"`
}

type PersonInput struct {
	Seed *string `json:"seed"`
}