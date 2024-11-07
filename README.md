# airline-management-system

## TODO

- [x] Setting up env
- [x] Different Roles Creation
  - [x] Granting access to Roles
  - [x] Unlimited disk space
- [x] Create Table
- [ ] Insert Data
- [ ] Create views

## Usage

> [!IMPORTANT]
> Create DB Admin using Oracle Cloud console

### Create users

1. Create `APP ADMIN` user

   > **Using account**: `DB ADMIN`

   ```sh
    env setup/create users/[1] create_app_admin_user.sql
   ```

2. Create all other users (Developer, HR, etc)
   > **Using account**: `APP ADMIN`

   ```sh
    env setup/create users/[2] create_all_users.sql
   ```

### Create Stored Procedures [APP ADMIN]

1. Create Store Procedure for `APP ADMIN`

   > **Using account**: `APP ADMIN`

   ```sh
    stored procedures/[3] grant_access_to_user.sql
   ```

### Grant Access to Developer

1. granting access to developer

    > **Using account**: `APP ADMIN`

   ```sh
    env setup/grant access/[4] grant_access_developer.sql
   ```

### Create Stored Procedures [DEVELOPER]

1. Create Store Procedure for `DEVELOPER`

   > **Using account**: `DEVELOPER`

   ```sh
    stored procedures/[3] grant_access_to_user.sql
   ```

### Create tables

1. Create tables using developer

   > **Using account**: `DEVELOPER`

  ```sh
    table setup/[5] Airline_Independent_Tables.sql
    table setup/[6] Airline_Dependent_Tables.sql
  ```

### Grant Access to tables for different users

1. Grant access to tables to different users

   > **Using account**: `DEVELOPER`

   ```sh
    env setup/grant access/[7] grant_access_to_all_users.sql
   ```
