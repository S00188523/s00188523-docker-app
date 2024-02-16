
FROM node:19.4.0 AS builder

WORKDIR /s00188523-docker-app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

COPY --from=builder /s00188523-docker-app/dist/s00188523-docker-app /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
