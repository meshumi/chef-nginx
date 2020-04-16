run `bundle install`
run `bersk install`

check that you have kitchen

run `kitchen list`

to run test

`kitchen test` - it rebuild containers and lunch tests
`kitchen verify` - create containers (only if they didn't build) and lunch tests
`kitchen destroy` - destroy containers

after tests a finish you should see something like this

<img width="1276" src="https://user-images.githubusercontent.com/12530754/79481893-c0c61980-8018-11ea-89f6-6cdff42addbb.png">
