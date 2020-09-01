# alpine-mongo
Creates an alpine based mongodb4.0 docker image

##### *Simple yet an elegant way to set up your test environment in just a couple of steps!!!*

:bulb: **Credentials**

[NOT FOR PRODUCTION USE]

Admin User
```
Admin username: admin
Admin user password: admin
```

Database User
```
DB username: mongo
DB user password: mongo
```

:bulb: **Way to setup for integration test**

Setup:
```
make teardown && make setup

```

Login to the mongodb container:
```
$ docker exec -ti mongodb sh -l
```
```
mongodb:/# mongo --authenticationDatabase admin -u mongo -p mongo test

MongoDB shell version v4.0.5
connecting to: mongodb://127.0.0.1:27017/test?authSource=admin&gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("b77c96cd-ce56-475b-8b8d-ab23b65fa712") }
MongoDB server version: 4.0.5
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
        http://docs.mongodb.org/
Questions? Try the support group
        http://groups.google.com/group/mongodb-user
```

Test:
```
> use test
switched to db test

> db.foo.insert({"a":1})
WriteResult({ "nInserted" : 1 })

> db.foo.find()
{ "_id" : ObjectId("5f4e3da2b4bba22a8b4bf92a"), "a" : 1 }
```

:bulb: **Teardown resources after you're done**

Teardown:
```
make teardown
```
