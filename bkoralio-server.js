// const express = require('express')
const express = require('express')
const path = require('path')
const app = express()

console.log(path.join(__dirname, '..', 'bkoralio_prod/build'))

app.use(express.static(path.join(__dirname, '..', 'bkoralio_prod/build')))

app.get('/', function (req, res) {
  res.sendFile(path.join(__dirname, './', 'index.html'))
})

app.listen(8080, () => {
  console.log(`Bkoral.io server is now running on port 8080`)
})
