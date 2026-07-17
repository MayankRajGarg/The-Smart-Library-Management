# Creating a docker image for a RESTful server, which provides 
# the functionality of JSON objects persistence, starting with a base image
# (gilhari) that already has jdxnode_rest_server installed
# and the appropriate environment varaibles (JX_HOME, NODE_PATH) set.

FROM softwaretree/gilhari
#FROM gilhari:0.8
WORKDIR /opt/gilhari_library

ADD bin ./bin
ADD config ./config
ADD gilhari_service.config .

EXPOSE 8081 
CMD ["node", "/node/node_modules/gilhari_rest_server/gilhari_rest_server.js",  "gilhari_service.config"]
