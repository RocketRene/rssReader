# RSS Aggregator Api 

### Instalation
1. Make sure docker is installed and running 
2. Install openTofu 
3. run `tofu init` 
4. run `tofu plan`
5. run `tofu apply`
6. install goose
7. run `cd sql/schema`
8. run `goose postgres "postgres://myuser:mypassword@localhost:5432/mydb" up`
9. now you can create a user by running `http POST localhost:8080/v1/users name=Rene`


#### TODOs 

Document how to create RSS Feeds 
