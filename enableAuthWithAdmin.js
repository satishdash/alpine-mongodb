//  NOT FOR PRODUCTION USAGE.
//  Creates a DBA user with a password
//  username = admin
//  password = admin
//  To be authenticated in the shell session as below:
//  mongo --authenticationDatabase "admin" -u admin -p "admin"
//  (ABOVE LINES ARE SINGLE LINE COMMENTS CAUSE MONGO SHELL WON'T BE ABLE TO HANDLE MULTI-LINE COMMENTS)
db.createUser({"user": "admin", "pwd": "admin", "roles": [{ "role": "userAdminAnyDatabase", "db": "admin" }]});
