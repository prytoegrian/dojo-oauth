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

// Create and configure Slim app
$config = ['settings' => [
        'addContentLengthHeader' => false,
    ],
    'view' => new PHPRenderer('/vendor/chadicus/slim-oauth2-routes/templates'),
];
$app = new \Slim\App($config);

// Init route
$app->get('/hello/{name}', function (IRequest $req, IResponse $resp, array $args) : IResponse {
    return $resp->write('Hello ' . $args['name']);
});

//Set-up the OAuth2 Server
$dsn = 'mysql:dbname=storage;host=mysql';
$username = 'root';
$password = 'root';
$storage = new Storage\Pdo(['dsn' => $dsn, 'username' => $username, 'password' => $password]);
$server = new OAuth2\Server($storage);
$authorizationCode = new GrantType\AuthorizationCode($storage);
$clientCredentials = new GrantType\ClientCredentials($storage);
// specify your audience (typically, the URI of the oauth server)
$audience = 'http://localhost:8080';
$jwtBearer = new GrantType\JwtBearer($storage, $audience);
$refreshToken = new GrantType\RefreshToken($storage);
$password = new GrantType\UserCredentials($storage);

$server->addGrantType($authorizationCode);
$server->addGrantType($clientCredentials);
$server->addGrantType($password);
$server->addGrantType($refreshToken);

// Global authorization and scoped route
$authorization = new Middleware\Authorization($server, $app->getContainer());

// Oauth routes
$app->map(['GET', 'POST'], Routes\Authorize::ROUTE, new Routes\Authorize($server, $config['view']))->setName('authorize');
$app->post(Routes\Token::ROUTE, new Routes\Token($server))->setName('token');
$app->map(['GET', 'POST'], Routes\ReceiveCode::ROUTE, new Routes\ReceiveCode($config['view']))->setName('receive-code');
$app->post(Routes\Revoke::ROUTE, new Routes\Revoke($server))->setName('revoke');


$app->get('/secret-route', function (IRequest $req, IResponse $resp, array $args) : IResponse {
    return $resp->write('This is a secret route');
})->add($authorization);

// Catch all route
$app->get('/', function (IRequest $req, IResponse $resp, array $args) : IResponse {
    return $resp->write('Hello world !');
});

// Run app
$app->run();


