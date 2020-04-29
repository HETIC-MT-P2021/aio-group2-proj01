FROM node:14-alpine AS builder
WORKDIR /app
COPY . .

RUN yarn global add elm ; \
    yarn global add create-elm-app ; \
    elm-app build


FROM nginx:1.17.9-alpine
COPY --from=builder /app/build /var/www/html
COPY default.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]
