FROM golang as builder

WORKDIR /usr/src/app

COPY app.go .

RUN go get github.com/pwaller/goupx
RUN go build -ldflags "-s -w" app.go
RUN strip app
RUN rm app.go
RUN chmod +x ./app

FROM scratch
WORKDIR /

COPY --from=builder /usr/src/app app

CMD [ "/app/app"]