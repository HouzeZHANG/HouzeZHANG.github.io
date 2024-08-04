# Use the official Hugo image as the base image
FROM klakegg/hugo:ext-alpine

# Copy the current directory contents into the container at /src
COPY . /src

# Set the working directory to /src
WORKDIR /src

# Build the Hugo site
RUN hugo --gc --minify --destination /public

# Use an nginx container to serve the content
FROM nginx:alpine
COPY --from=0 /public /usr/share/nginx/html
