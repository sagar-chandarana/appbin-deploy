var child_process = require('child_process');
var gui = require('nw.gui');

function disableExit(state){
   removeTitlebar("top-titlebar");
   addTitlebar("top-titlebar", "appbin_icon.png", "Install Appbin",state);
}

function onInstallComplete(){
    document.getElementById("install_appbin").disabled = false;
	document.getElementById("install_appbin").value="Open Appbin";
	document.getElementById( "install_appbin" ).setAttribute( "onClick", "onCloseClick();" )
	disableExit(false);
	changeTextArea("Installation complete.");
}

function onCloseClick(){
    
    child_process.exec(process.env.HOME+"/.appbin/program_files/appbin",process.env.HOME+"/.appbin/program_files");
    child_process.exec(process.env.HOME+"/.appbin/program_files/appbin_daemon",process.env.HOME+"/.appbin/program_files");
    console.log("Called appbin.");
    gui.App.quit();
}

function installAppbin() {
   document.getElementById("install_appbin").value="Installing...";
   document.getElementById("install_appbin").disabled = true;
   disableExit(true);
   changeTextArea('Please wait...');   
   // execFile: executes a file with the specified arguments

   var path = require("path");


   cwd = path.resolve("./");
   console.log("path: "+cwd);
   var installProc = child_process.execFile(cwd+"/install.sh", cwd, function(error, stdout, stderr){
        console.log("stdout: " + stdout);
        console.log("stderr: " + stderr);
        if (error !== null) {
            console.log("error: " + error);
        }
    });

    installProc.on("close",onInstallComplete);
}

function changeTextArea(newText) {
   document.getElementById("textPolicy").value=newText;
}

function minimize() {

// Load native UI library
var gui = require('nw.gui'); //or global.window.nwDispatcher.requireNwGui() (see https://github.com/rogerwang/node-webkit/issues/707)

// Get the current window
var win = gui.Window.get();

// Listen to the minimize event
win.on('minimize', function() {
  console.log('Window is minimized');
});

// Minimize the window
win.minimize();


}



window.onresize = function() {
  updateContentStyle();
}

window.onload = function() {

    addTitlebar("top-titlebar", "appbin_icon.png", "Install Appbin",false);

    focusTitlebars(true);

    updateContentStyle();
		
		
  
  
 
  
  document.getElementById("close-window-button").onclick = function() {
    window.close();
  }
      updateContentStyle();
  
  require("nw.gui").Window.get().show();
}
