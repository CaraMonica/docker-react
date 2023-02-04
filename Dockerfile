FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build has all the info our production env needs
# Need to copy this into our second build step for nginx
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html