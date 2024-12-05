# Flows

## Passenger booked a flight

1. Register a new user
   > **Using account**: `PASSENGER`
   ```sh
   stored procedures/[1.1] register_user.sql
   ```

2. Find available flight
   > **Using account**: `PASSENGER`

   ```sh
   stored procedures/[1.2] find_available_flights.sql
   ```

3. Find available seats
   > **Using account**: `PASSENGER`

   ```sh
   stored procedures/[1.3 ] find_available_seats.sql
   ```

4. Book a flight
   > **Using account**: `PASSENGER`

   ```sh
   stored procedures/[1.4] book_a_flight.sql
   ```

5. Add Bag to reservation
   > **Using account**: `PASSENGER`

   ```sh
   stored procedures/[1.5] add_bag_to_reservation.sql
   ```

6. Travel in flight
   > **Using account**: `GROUND OPERATION MANAGER`

   ```sh
   stored procedures/[1.6] travel_a_flight.sql
   ```

7. Land a flight
   > **Using account**: `FLIGHT OPERATION MANAGER`

   ```sh
   stored procedures/[1.7] land_a_flight.sql
   ```

8. Unloaded the baggae
   > **Using account**: `FLIGHT OPERATION MANAGER`

   ```sh
   stored procedures/[1.7] land_a_flight.sql
   ```


## Run package - Staff Management (Create Staff and Assign Job)

1. Create crew employee
   > **Using account**: `HR_MANAGER`

  ```sh
    package/[ ] staff_management.sql
  ```

2. Run crew assignment using CREW_MANAGER - To assign crew to flight schedule 
   > **Using account**: `CREW_MANAGER`

  ```sh
    package/[ ] crew_assignment_check.sql
  ```

1. Create pilot employee
   > **Using account**: `HR_MANAGER`

  ```sh
    package/[ ] staff_management.sql
  ```

2. Run crew assignment using CREW_MANAGER - To assign pilot to flight schedule 
   > **Using account**: `CREW_MANAGER`

  ```sh
    package/[ ] crew_assignment_check.sql
  ```

1. Create ground staff employee
   > **Using account**: `HR_MANAGER`

  ```sh
    package/[ ] staff_management.sql
  ```

## Run procedures / functions - Maintenance and Inventory Management

1. Check if maintenance is scheduled for aircraft
   > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.1] check_maintenance_schedule.sql
  ```

2. Create and return maintenance schedule id
   > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.2] create_and_return_maintenance_schedule_id.sql
  ```

3. Check whether sufficient inventory available
    > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.3] check_inventory.sql
  ```

4. Record Maintenance Log
   > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.4] record_maintenance.sql
  ```

5. Place inventory available if insufficient
   > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.5] place_inventory_order.sql
  ```

6. Get maintenance schedule schedule id:
   > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.6] get_main_schedule_id.sql
  ```

7. Execute all the maintenance and inventory operation calls
    > **Using account**: `MAINTENANCE_MANAGER`

  ```sh
    procedures/[7.7] execute_maintenance_ops.sql
  ```