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
