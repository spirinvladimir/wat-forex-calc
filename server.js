fs=require('fs')
http=require('http')

http.createServer((req, res) => {
    if (req.url == '/')
        res.end(fs.readFileSync('price-for-amount.html'))
    if (req.url == '/price_by_amount.js')
        res.end(fs.readFileSync('price_by_amount.js'))
    if (req.url == '/price_by_amount.css')
        res.end(fs.readFileSync('price_by_amount.css'))
    if (req.url == '/main.wasm')
        res.end(fs.readFileSync('main.wasm'))
}).listen(8080)
