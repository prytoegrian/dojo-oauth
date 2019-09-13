## Démarrage

Lancer le serveur avec:
```sh
make up
```

Contacter le serveur avec:
```sh
curl http://localhost:8080
```

Couper le serveur avec:
```sh
make down
```

## Token
curl https://api.mysite.com/token -d 'grant_type=authorization_code&client_id=TestClient&client_secret=TestSecret&code=xyz'
curl http://localhost:8080/token -d 'grant_type=password&client_id=TestClient&username=bshaffer&password=brent123'
curl http://localhost:8080/token -d 'grant_type=client_credentials&client_id=TestClient&client_secret=TestSecret'
curl http://localhost:8080/token -d 'grant_type=refresh_token&client_id=TestClient&client_secret=TestSecret&refresh_token=tGzv3JOkF0XG5Qx2TlKWIA'
curl http://localhost:8080/token -d 'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=$jwt'

https://oauth.net/2/grant-types/password/ : when the client is trusted, as the user's password is transmitted.

## Authorization
curl http://localhost:8080/authorize?response_type=code&client_id=TestClient&redirect_uri=https://myredirecturi.com/cb
https://myredirecturi.com/cb?code=SplxlOBeZQQYbYS6WxSbIA&state=xyz
curl http://localhost:8080/token -d 'grant_type=authorization_code&client_id=TestClient&client_secret=TestSecret&code=xyz'
