var path = require("path");

var child_process = require('child_process');

// execFile: executes a file with the specified arguments

cwd = path.resolve("./");
console.log("path: "+cwd);
var installProc = child_process.execFile(cwd+"/install.sh", cwd, function(error, stdout, stderr){
    console.log("stdout: " + stdout);
    console.log("stderr: " + stderr);
    if (error !== null) {
        console.log("error: " + error);
    }
});

installProc.on("close",onInstallFinish);