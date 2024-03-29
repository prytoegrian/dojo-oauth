# Dojo Oauth
Ce repo a pour objectif de fournir un support de formation pour comprendre ce qu'est Oauth et comment il s'utilise.

## Installation et informations générales
### Démarrage

Lancer le serveur avec:
```sh
make up
```

Contacter le serveur avec:
```sh
curl http://oauth.local:8080
```

Couper le serveur avec:
```sh
make down
```

Allumer le serveur :
```sh
make start
```

Éteindre le serveur :
```sh
make stop
```

### Token
curl http://oauth.local:8080/token -d 'grant_type=authorization_code&client_id=TestClient&client_secret=TestSecret&code=xyz&redirect_uri=http://example.org'  
curl http://oauth.local:8080/token -d 'grant_type=password&client_id=TestClient&username=bshaffer&password=brent123'  
curl http://oauth.local:8080/token -d 'grant_type=client_credentials&client_id=TestClient&client_secret=TestSecret'  
curl http://oauth.local:8080/token -d 'grant_type=refresh_token&client_id=TestClient&client_secret=TestSecret&refresh_token=tGzv3JOkF0XG5Qx2TlKWIA'  
curl http://oauth.local:8080/token -d 'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=Jwt'  

https://oauth.net/2/grant-types/password/ : when the client is trusted, as the user's password is transmitted.

### Authorization
curl http://oauth.local:8080/authorize?response_type=code&client_id=TestClient&redirect_uri=https://myredirecturi.com/cb
https://myredirecturi.com/cb?code=SplxlOBeZQQYbYS6WxSbIA&state=xyz
curl http://localhost:8080/token -d 'grant_type=authorization_code&client_id=TestClient&client_secret=TestSecret&code=xyz'

### Accéder à une route authentifiée
Mettre dans un header `Authorization: Bearer AccessToken`

### JWT life cycle
https://jwt.io/
client_id en payload.iss
subject en payload.sub
audience égale à celle stockée en config
public_key dans la signature
