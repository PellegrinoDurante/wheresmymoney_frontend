FROM node:18-alpine as build
WORKDIR /app
COPY . /app
RUN npm install && npm run build

FROM nginx:1.23.1-alpine
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]