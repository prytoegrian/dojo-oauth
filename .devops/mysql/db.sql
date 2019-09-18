CREATE DATABASE IF NOT EXISTS storage;
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

-- grant_type client_credentials
INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('client_client', 'client_client_secret', '', 'client_credentials', '', '5');

-- grant_type auth_code
insert into oauth_authorization_codes (authorization_code, client_id, user_id, redirect_uri, expires, scope, id_token) values ('auth_code_1', 'client_auth_code', 'user_auth_code', 'http://example.org', '2019-10-20', 'test', 42);
INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('client_auth_code', 'client_auth_code_secret', '', 'authorization_code', '', '8');

-- grant_type password
INSERT INTO oauth_users (username, password, first_name, last_name, email, email_verified, scope) VALUES ('username', sha1('password'), 'first_name_1', 'last_name_1', 'email_1', 2, '');
INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('client_password', 'client_password_secret', '', 'password', '', '98');

-- grant_type password with scope
-- INSERT INTO oauth_users (username, password, first_name, last_name, email, email_verified, scope) VALUES ('username_scoped', sha1('password_scoped'), 'first_name_2', 'last_name_2', 'email_1', 2, 'read-only');

-- grant_type refresh_token
-- INSERT INTO oauth_users (username, password, first_name, last_name, email, email_verified, scope) VALUES ('username_refresh', sha1('password_refresh'), 'first_name_2', 'last_name_2', 'email_2', 100, '');
-- INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('client_refresh', 'client_refresh_secret', '', 'password refresh_token', '', '298');

-- grant_type jwt
INSERT INTO oauth_jwt (client_id, subject, public_key) VALUES ('client_jwt', 'client_jwt_secret', 'client_jwt_public_key');
INSERT INTO oauth_clients (client_id, client_secret, redirect_uri, grant_types, scope, user_id) VALUES ('client_jwt', 'client_jwt_secret', '', 'urn:ietf:params:oauth:grant-type:jwt-bearer', '', '9812');

-- grant_type multiples
