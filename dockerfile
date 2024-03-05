# Use the official Golang image to create a build artifact.
# This is based on Debian and sets the GOPATH to /go.
FROM golang:1.22-alpine as builder

# Create and change to the app directory.
WORKDIR /app

# Copy the local package files to the container's workspace.
COPY . .

# Fetch dependencies.
# Using go mod with Go 1.11 modules.
RUN go mod download

# Build the command inside the container.
# (You may need to modify the path or the main file name depending on your project structure)
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o rssReader .

# Use a Docker multi-stage build to create a lean production image.
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM alpine:latest  

# Copy the binary from the builder stage.
COPY --from=builder /app/rssReader .

# Run the rssReader binary.
CMD ["./rssReader"]
