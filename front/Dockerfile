FROM node:alpine
WORKDIR /app

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH

RUN yarn global add create-elm-app@4.2.14

EXPOSE 3000