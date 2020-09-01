FROM alpine:latest
WORKDIR /

# [pointers]
#   Below repository links are added as MongoDB has been removed since alpine3.10
#   https://alpinelinux.org/posts/Alpine-3.10.0-released.html
#   https://unix.stackexchange.com/questions/568530/installing-mongodb-on-alpine-3-9

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/main' >> /etc/apk/repositories
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.9/community' >> /etc/apk/repositories

RUN apk update
RUN apk add --no-cache mongodb yaml-cpp=0.6.2-r2 openssl
VOLUME /data/db
EXPOSE 27017 27018 27019

# generate ca.pem file for testing purposes and start mongod process with that
#   https://docs.mongodb.com/manual/appendix/security/appendixA-openssl-ca/#b-generate-the-test-ca-pem-file
#   NOTES:
#       - https://jira.mongodb.org/browse/SERVER-10495
COPY . /

RUN openssl genrsa -out mongodb-test-ca.key 4096
RUN openssl req -new -x509 -days 1826 -key mongodb-test-ca.key -out mongodb-test-ca.crt \
-subj "/C=US/ST=California/L=ParkwayBridge/O=Example/OU=Labs Department/CN=localhost,*.com"
RUN openssl genrsa -out mongodb-test-ia.key 4096
RUN openssl req -new -key mongodb-test-ia.key -out mongodb-test-ia.csr \
-subj "/C=NL/ST=Zuid Holland/L=Rotterdam/O=Sparkling Network/OU=IT Department/CN=localhost,*.com" \
-config openssl-test-ca.cnf
RUN openssl x509 -sha256 -req -days 730 -in mongodb-test-ia.csr -CA mongodb-test-ca.crt -CAkey mongodb-test-ca.key \
-set_serial 01 -out mongodb-test-ia.crt -extfile /openssl-test-ca.cnf -extensions v3_ca
RUN cat mongodb-test-ca.key mongodb-test-ca.crt  > /ca.pem

CMD [ "mongod", \
"--auth", \
"--bind_ip_all", \
"--sslMode", "allowSSL", \
"--sslPEMKeyFile", "/ca.pem", \
"--sslAllowConnectionsWithoutCertificates", \
"--sslAllowInvalidCertificates" \
]
