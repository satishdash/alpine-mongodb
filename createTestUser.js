//  NOT FOR PRODUCTION USAGE.
//  Creates a DB user with a password
//  username = mongo
//  password = mongo
//  To be authenticated in the shell session as below:
//  mongo --authenticationDatabase "admin" -u "mongo" -p "mongo"
//  This script is run as below:
//  mongo --authenticationDatabase "admin" -u "admin" -p "admin" < createTestUser.js
//  (ABOVE LINES ARE SINGLE LINE COMMENTS CAUSE MONGO SHELL WON'T BE ABLE TO HANDLE MULTI-LINE COMMENTS)
db.createUser({"user": "mongo", "pwd": "mongo", "roles": [{ "role": "readWrite", "db": "test" }]});
