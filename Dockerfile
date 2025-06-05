FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json /
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
RUN npm install -g serve
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["serve", "-s", "build", "-l", "80"]