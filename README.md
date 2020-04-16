run `bundle install`
run `bersk install`

check that you have kitchen

run `kitchen list`

to run test

`kitchen test` - it rebuild containers and lunch tests
`kitchen verify` - create containers (only if they didn't build) and lunch tests
`kitchen destroy` - destroy containers

after tests a finish you should see something like this

![specs pass](https://monosnap.com/file/vxYzfKvN1RgYE3Af8VDOgv0XKoiRDP)
