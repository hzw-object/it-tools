# build stage
FROM node:16.20 AS build-stage
WORKDIR /app
COPY . .
RUN node -v
RUN npm install -g pnpm
RUN pnpm i 
RUN pnpm build

# production stage
FROM nginx:stable-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]