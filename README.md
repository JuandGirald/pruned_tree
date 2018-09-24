# Rpunning Tree

## Installing

Inside your project, run this command:

```
Bundle install
```
## Database

run:

```
rake db:setup && rake db:migrate
```

then run:

```
rails server
```


## Running the tests


run the tests!

```
rspec
```

## Endpoints

Get the prunned tree:
```
/tree/<name>
params: indicator_ids[]

ex:

http://localhost:3000/tree/input?indicator_ids[]=50&indicator_ids[]=2&indicator_ids[]=15
```

## Authors

* **Juan David Giraldo** - *Initial work* - [JuanGiraldo](https://github.com/JuandGirald)

