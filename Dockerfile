FROM node:18-alpine as builder

USER node
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
# The dot ( . ) below  means copy file to WORKDIR
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node . .
RUN npm run build

#step 2 copying bare minimum from builder/step 1
FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html