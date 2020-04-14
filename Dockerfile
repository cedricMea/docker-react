# on ici un dockerfile pour le server de production

# on va faire deux phases car on a besoin de deux images. 
# Une première où on construit le builder de l'appli 
# Et une seconde où on copie ce builder là dans une machine avec nginx

# 1ere phase
# on commence par renomer cette 1ere phase 
FROM node:alpine as build

WORKDIR /app
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build


# 2e phase
FROM nginx
EXPOSE 80 
 # Elasticbeanstalk va directement mapper le port 
# we copy the builder from the builder container to  the nginx container
# In the nginx container we might pull the builder in  
# /usr/share/nginx/html
COPY --from=build /app/build  /usr/share/nginx/html

# We dont need to start explicirely this container. The default starter is already 
# set



