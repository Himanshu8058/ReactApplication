# Install dependencies and build
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Production image
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app ./
EXPOSE 3000

CMD ["npm", "start"]
