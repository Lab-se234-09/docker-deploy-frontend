# Setup Nodejs and build angular
FROM node:10-alpine as node 
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
ARG TARGET=ng-deploy
RUN npm run ${TARGET}

# based on nginx server for production app
FROM nginx:1.13
COPY --from=node /app/dist/  /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

EXPOSE 80