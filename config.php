
<?php

$app['debug'] = true;
$app['mongodb.client.uri'] = 'mongodb://mongodb:27017/docker';
$app['mongodb.client.uriOptions'] = [];
$app['mongodb.client.driverOptions'] = [];
$app['twig.cache_dir'] = sys_get_temp_dir() . '/mongoqp-cache';
