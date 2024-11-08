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

### Insert Data into table

1. Insert data

   > **Using account**: `DEVELOPER`

   ```sh
      [1] insert_data/aircraft_insert_data.sql
      [2] insert_data/route_insert_data.sql
      [3] insert_data/maintenance_schedule_insert_data.sql
      [4] insert_data/inventory_insert_data.sql
      [5] insert_data/employee_insert_data.sql
      [6] insert_data/passenger_insert_data.sql
      [7] insert_data/inventory_order_insert_data.sql
      [8] insert_data/flight_schedule_insert_data.sql
      [9] insert_data/seat_insert_data.sql
      [10] insert_data/crew_assignment_insert_data.sql
      [11] insert_data/maintenance_record_insert_data.sql
      [12] insert_data/ground_ops_schedule.sql
      [13] insert_data/reservation_insert_data.sql
      [14] insert_data/payment_insert_data.sql
      [15] insert_data/reservation_payment_insert_data.sql
      [16] insert_data/wallet_insert_data.sql
      [17] insert_data/baggage_insert_data.sql
      [18] insert_data/refund_insert_data.sql
   ```

### Create View

1. Create views: quarterly most travelled route
   > **Using account**: `FLIGHT_OPERATION_MANAGER`
   ```sh
      views setup/[19] quarterly_most_travelled_route.sql
   ```

2. Create views: most wallet points redeemed
   > **Using account**: `DEVELOPER`
   ```sh
      views setup/[20] most_wallet_points_redeemed.sql
   ```

3. Create views: incoming cashflow.sql
   > **Using account**: `DEVELOPER`
   ```sh
      views setup/[21] incoming_cashflow.sql
   ```

4. Create views: scheduled maintenance record
   > **Using account**: `MAINTENANCE MANAGER`
   ```sh
      views setup/[22] scheduled_maintenance_record.sql
   ```
