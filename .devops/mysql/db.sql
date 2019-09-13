CREATE DATABASE IF NOT EXISTS storage;
use storage;

CREATE TABLE oauth_clients (
    client_id             VARCHAR(80)   NOT NULL,
    client_secret         VARCHAR(80),
    redirect_uri          VARCHAR(2000),
    grant_types           VARCHAR(80),
    scope                 VARCHAR(4000),
    user_id               VARCHAR(80),
    PRIMARY KEY (client_id)
);

CREATE TABLE oauth_access_tokens (
    access_token         VARCHAR(40)    NOT NULL,
    client_id            VARCHAR(80)    NOT NULL,
    user_id              VARCHAR(80),
    expires              TIMESTAMP      NOT NULL,
    scope                VARCHAR(4000),
    PRIMARY KEY (access_token)
);

CREATE TABLE oauth_authorization_codes (
    authorization_code  VARCHAR(40)     NOT NULL,
    client_id           VARCHAR(80)     NOT NULL,
    user_id             VARCHAR(80),
    redirect_uri        VARCHAR(2000),
    expires             TIMESTAMP       NOT NULL,
    scope               VARCHAR(4000),
    id_token            VARCHAR(1000),
    PRIMARY KEY (authorization_code)
);

CREATE TABLE oauth_refresh_tokens (
    refresh_token       VARCHAR(40)     NOT NULL,
    client_id           VARCHAR(80)     NOT NULL,
    user_id             VARCHAR(80),
    expires             TIMESTAMP       NOT NULL,
    scope               VARCHAR(4000),
    PRIMARY KEY (refresh_token)
);

CREATE TABLE oauth_users (
    username            VARCHAR(80),
    password            VARCHAR(80),
    first_name          VARCHAR(80),
    last_name           VARCHAR(80),
    email               VARCHAR(80),
    email_verified      BOOLEAN,
    scope               VARCHAR(4000),
    PRIMARY KEY (username)
);

CREATE TABLE oauth_scopes (
    scope               VARCHAR(80)     NOT NULL,
    is_default          BOOLEAN,
    PRIMARY KEY (scope)
);

CREATE TABLE oauth_jwt (
    client_id           VARCHAR(80)     NOT NULL,
    subject             VARCHAR(80),
    public_key          VARCHAR(2000)   NOT NULL
);

INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('client_1', 'client_secret_1', '', 'client_credentials', '', '5');

INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('912837', 'password_rand', '', 'client_credentials password', '', 'myId');
INSERT INTO oauth_users (username, password, first_name, last_name, email, email_verified, scope) VALUES ('912837', sha1('password_rand'), 'first_name_2', 'last_name_2', 'email_2', 2, '');
