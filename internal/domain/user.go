package domain

import "time"

type User struct {
	Email    string
	Password string
	Ctime    time.Time
	Id       int64

	Nickname string
	Birthday time.Time
	AboutMe  string
}
