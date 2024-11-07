# airline-management-system

## TODO

- [ ] Setting up env
- [ ] Different Roles Creation
  - [ ] Granting access to Roles
  - [ ] Unlimited disk space
- [ ] Create Table
- [ ] Insert Data
- [ ] Create views

## Usage

1. Create `App Admin` user using `Oracle DBA admin` account

   ```sh
    [1] create_app_admin_user.sql
   ```

2. Create all the users using `App Admin` account

  ```sh
    [2] create_all_users.sql
  ```
  
3. Create all the stored procedures in `stored procedures` folder

  ```sh
    grant_access_to_user.sql;
  ```

4. Grant access to `developer` user

  ```sh
    [3] grant_access_developer.sql
  ```

5. Create tables

  ```sh
    [5] Airline_Independent_Tables.sql
    [6] Airline_Dependent_Tables.sql
  ```

6. Grant access to tables to different users
  
   ```sh
    [4] grant_access_to_users.sql
  ```
