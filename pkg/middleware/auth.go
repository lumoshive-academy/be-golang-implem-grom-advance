package middleware

import (
	"context"
	"net/http"
)

func Auth(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx := r.Context()
		// get ID form token
		ID := "2"
		ctx = context.WithValue(ctx, "ctxid", ID)
		next.ServeHTTP(w, r.WithContext(ctx))
	})

}
