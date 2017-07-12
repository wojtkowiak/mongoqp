mongoqp
=======

**mongoqp** is a frontend for MongoDB's [query profiler][] collections (i.e.
`db.system.profile`), built using [Silex][] and [MongoDB PHP Library][].

It currently supports:

 * Toggling query profiler levels (off, slow, all) per database
 * Grouping similar queries by BSON structure
 * Reporting aggregate query statistics (min, max, average, times)
 * Sorting, pagination and filtering via [DataTables][]

Future plans:

 * Control over slow query thresholds
 * Improving analytics
 * Persistent data collection

### Screenshots

![Server view](http://i.imgur.com/5EZbm.png)

![Database view](http://i.imgur.com/pXLc4.png)

## Setup

### Installation

Dependencies are managed with [Composer][], a PHP package manager. This project
is also published as a package, which means it can be installed with:

```
$ composer create-project jmikola/mongoqp
```

### Configuration

The `src/` directory includes a `config.php.dist` file, which may be copied
to `config.php` and customized. If `config.php` is not present, the default
configuration will be included.

Currently, the following options are available:

 * `debug`: Enable verbose error reporting
 * `mongodb.client.uri`: MongoDB connection URI string
 * `mongodb.client.uriOptions`: MongoDB connection URI options
 * `mongodb.client.driverOptions`: MongoDB driver options
 * `twig.cache_dir`: Cache directory for Twig templates

#### Database Connection

By default, the application will connect to a standalone MongoDB server on the
local host (i.e. `new MongoDB\Client`). The connection may be customized via the
`mongodb.client` options, like so:

```php
$app['mongodb.client.uri'] = 'mongodb://example.com:27017';
```

The above example connects to a standalone server by its hostname. Consult the
[MongoDB PHP library documentation][] for additional examples on connecting
to a replica set or specifying auth credentials.

Database profiling cannot be enabled on `mongos` instances. If you are profiling
queries in a sharded cluster, the application should be configured to connect to
an individual shard.

#### Cache Directory

By default, the application will use `mongoqp-cache/` within the system's
temporary directory. This path, which must be writable, may be customized via
the `twig.cache_dir` configuration option.

#### Docker Setup 
Clone the repo

You just have to add the mongo uri in config.php.dist and run commands : 
```
$ docker build -t mongoqp .
```

then run it using 

```
$ docker run -p 8080:8080 mongoqp
```


If you want to connect the host machine MongoDB open your terminal and then : 

### for MAC/LINUX:

```
ifconfig
```

then output will be something like this in mac : 
```
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	ether f0:79:60:2b:4b:84 
	inet6 fe80::14c2:77d2:3780:7e54%en0 prefixlen 64 secured scopeid 0x4 
	inet 192.168.1.67 netmask 0xfffff800 broadcast 192.168.7.255
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
	
```
  
just pick this ip 192.168.1.67 and you can pass it to config.php.

same can be done in the linux.


### in Windows open command prompt : 

```
ipconfig
```

you can find your ip there 


### NOTE: You may require to set your date.timezone in php.ini file for that you can access you docker by command:

```
docker ps 
```

Output will be like  : 

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                 
1b8d8ce2d0e2        composer1           "php -S 0.0.0.0:80..."   20 hours ago        Up 8 hours         0.0.0.0:8080->8080/tcp
66ad43771d39        composer1           "php -S 0.0.0.0:80..."   20 hours ago        Up 8 hours          8080/tcp             

just hit command: 

```
docker exec -it 1b8d8ce2d0e2 /bin/bash
```

you will get a prompt to your docker and then you can do relevent changes required.





### Web Server

The application can be started using:

```
$ php -S localhost:8080 -t web
```

Instructions for other web server configurations are outlined in the
[Silex documentation][].

  [query profiler]: https://docs.mongodb.com/manual/tutorial/manage-the-database-profiler/
  [Silex]: https://silex.sensiolabs.org/
  [MongoDB PHP Library]: https://github.com/mongodb/mongo-php-library
  [DataTables]: http://datatables.net/
  [Composer]: http://getcomposer.org/
  [MongoDB PHP library documentation]: https://docs.mongodb.com/php-library/master/reference/method/MongoDBClient__construct/#examples
  [Silex documentation]: https://silex.sensiolabs.org/doc/2.0/web_servers.html
