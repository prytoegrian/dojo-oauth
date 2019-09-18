<?php declare(strict_types = 1);

define('DS', DIRECTORY_SEPARATOR);

require_once dirname(__DIR__) . DS . 'vendor' . DS . 'autoload.php';
ini_set('display_errors', '1');error_reporting(E_ALL);

use Chadicus\Slim\OAuth2\Middleware;
use Chadicus\Slim\OAuth2\Routes;
use OAuth2\GrantType;
use OAuth2\Storage;
use Slim\Views\PhpRenderer;
use Psr\Http\Message\ServerRequestInterface as IRequest;
use Psr\Http\Message\ResponseInterface as IResponse;

//
// Create and configure Slim app
//
$config = [
    'settings' => [
        'addContentLengthHeader' => false,
        'displayErrorDetails' => true,
    ],
    'view' => new PHPRenderer('/vendor/chadicus/slim-oauth2-routes/templates'),
];
$app = new \Slim\App($config);

//
//Set-up the OAuth2 Server
//
$dsn = 'mysql:dbname=storage;host=mysql';
$username = 'root';
$password = 'root';
$storage = new Storage\Pdo(['dsn' => $dsn, 'username' => $username, 'password' => $password]);
$server = new OAuth2\Server($storage);
// Add grant_type
$authorizationCode = new GrantType\AuthorizationCode($storage);
$clientCredentials = new GrantType\ClientCredentials($storage);
$password = new GrantType\UserCredentials($storage);
$refreshToken = new GrantType\RefreshToken($storage);
// specify your audience (typically, the URI of the oauth server)
$audience = 'http://oauth.local:8080';
$configJwt = ['allowed_algorithms' => 'HS256'];
$jwtBearer = new GrantType\JwtBearer($storage, $audience, null, $configJwt);
// Open server to some grant types
$server->addGrantType($authorizationCode);
$server->addGrantType($clientCredentials);
$server->addGrantType($password);
$server->addGrantType($jwtBearer);

//
// Global authorization and scoped route middlware
//
$authorization = new Middleware\Authorization($server, $app->getContainer());

//
// Oauth routes
//
$app->map(['GET', 'POST'], Routes\Authorize::ROUTE, new Routes\Authorize($server, $config['view']))->setName('authorize');
$app->post(Routes\Token::ROUTE, new Routes\Token($server))->setName('token');
$app->map(['GET', 'POST'], Routes\ReceiveCode::ROUTE, new Routes\ReceiveCode($config['view']))->setName('receive-code');
$app->post(Routes\Revoke::ROUTE, new Routes\Revoke($server))->setName('revoke');

//
// Routes definition
//
$app->get('/secret-route', function (IRequest $req, IResponse $resp, array $args) : IResponse {
    return $resp->write('This is a secret route');
});

$app->get('/inner-scoped-route', function (IRequest $req, IResponse $resp, array $args) : IResponse {
    return $resp->write('This is a inner scoped route');
});

// Catch all route
$app->get('/', function (IRequest $req, IResponse $resp, array $args) : IResponse {
    return $resp->write('Hello world !');
});

// Run app
$app->run();
