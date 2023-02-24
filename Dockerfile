# Build Phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# creates a /app/build folder

# Run Phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# as nginx doc on Docker Hub recommends using this folder to store static files you're serving up
# also when you start the nginx container, you don't need any commands, it will start nginx automatically