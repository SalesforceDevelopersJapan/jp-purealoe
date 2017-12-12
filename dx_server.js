var http = require("http");
console.log("test");
http.createServer(function (req, res) {
    console.log(process.env.SCRATCHORG_LOGIN_URL);
    console.log("test");
    if(process.env.SCRATCHORG_LOGIN_URL){
        res.writeHead(200, {"Content-Type": "text/plain"});
        res.end("Now createting Salesforce Environment. Please access again after few miunites\n");
    }else{
        response.writeHead(301, {'Location': process.env.SCRATCHORG_LOGIN_URL, 'Expires': (new Date).toGMTString()});
        response.end();
    }
}).listen(process.env.PORT || 5000);
console.log("test");
