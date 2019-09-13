<?php

define('DS', DIRECTORY_SEPARATOR);

require_once dirname(__DIR__) . DS . 'vendor' . DS . 'autoload.php';

use Chadicus\Slim\OAuth2\Routes;
use OAuth2\GrantType;
use OAuth2\Storage;
use Slim\Views\PhpRenderer;


// Create and configure Slim app
$config = ['settings' => [
        'addContentLengthHeader' => false,
    ],
    'view' => new PHPRenderer('/vendor/chadicus/slim-oauth2-routes/templates'),
];
$app = new \Slim\App($config);

// Init route
$app->get('/hello/{name}', function ($request, $response, $args) {
    return $response->write("Hello " . $args['name']);
});

//Set-up the OAuth2 Server
$dsn = 'mysql:dbname=storage;host=mysql';
$username = 'root';
$password = 'root';
$storage = new Storage\Pdo(['dsn' => $dsn, 'username' => $username, 'password' => $password]);
$server = new OAuth2\Server($storage);
$server->addGrantType(new GrantType\AuthorizationCode($storage));
$server->addGrantType(new GrantType\ClientCredentials($storage));

$container = $app->getContainer();
//var_dump($container);exit();

$app->map(['GET', 'POST'], Routes\Authorize::ROUTE, new Routes\Authorize($server, $container['view']))->setName('authorize');
$app->post(Routes\Token::ROUTE, new Routes\Token($server))->setName('token');
$app->map(['GET', 'POST'], Routes\ReceiveCode::ROUTE, new Routes\ReceiveCode($container['view']))->setName('receive-code');
$app->post(Routes\Revoke::ROUTE, new Routes\Revoke($server))->setName('revoke');

// Catch all route
$app->get('/', function ($request, $response, $args) {
    return $response->write("H");
});

// Run app
$app->run();


