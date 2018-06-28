
Install postgresql with homebrew on Macbook Pro OSX 10.10.5
-----------------------------------------------------------

Run `brew` on the terminal to confirm that you have brew installed.

Then run `brew install postgresql` this should take around 5 min 40 sec depending on your internet speed.

To start up postgresql: `brew services start postgresql`

Fixing postgres error while creating the database repo on your local machine 

In the local dir of your project run:
`createdb`
`psql -h localhost`
This gives you access to the database.

Create a username:
`CREATE ROLE postgres WITH LOGIN ENCRYPTED PASSWORD 'password';`
This creates a new user and password. 

If the role already exists run the following to create a new one:
`Alter role user postgres with new_role_name`

Run `mix test` should return the number of tests and 0 failures if there is no error in your test.
