### Location
```.config/pgcli```

### Installation
* Info - https://www.pgcli.com/install
* macos - `brew install postgresql`
* arch - `yay -S pgcli`


### How create fast access to db
1. create file exp.: `LOCAL_DB_tableName.sh`
2. make file executable for file `chmod +x LOCAL_DB_tableName.sh`
3. add connection string to file
    ```
        pgcli postgresql://user_name:password@host_name:port/db_name
    ```
