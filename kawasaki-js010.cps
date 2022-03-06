/**
  Copyright (C) AutonoMoose Technology
  All rights reserved.
*/

description = "Kawasaki Heavy Industries - JS010 AD Controller";
vendor = "AutonoMoose Technology";
vendorUrl = "https://autonomoose.technology";
legal = "Copyright (C) 2012-2022 by AutonoMoose Technology";
longDescription = "Custom post processor for the Kawasaki JS010 robot arm to allow it to perform machining operations";
certificationLevel = 2;
minimumRevision = 45702;

extension = "as";
programNameIsInteger = false;
setCodePage("ascii");

capabilities = CAPABILITY_MILLING | CAPABILITY_TURNING;
tolerance = spatial(0.1, MM);

highFeedrate = (unit == IN) ? 100 : 1000;
minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = true;
allowSpiralMoves = true;
allowedCircularPlanes = 0;

// configuration
properties = {

};

// property groups
groupDefinitions = {

};

// coolant/vacuum options
var singleLineCoolant = false;
var coolants = [
  {id:COOLANT_AIR},
  {id:COOLANT_SUCTION},
  {id:COOLANT_OFF}
];

// formatting options
var xyzFormat = createFormat({decimals:2, forceDecimal:true});
var xOutput = createVariable({prefix:"", force:true}, xyzFormat);
var yOutput = createVariable({prefix:"", force:true}, xyzFormat);
var zOutput = createVariable({prefix:"", force:true}, xyzFormat);
var oatFormat = createFormat({decimals:2, forceDecimal:true});
var oOutput = createVariable({prefix:"", force:true}, oatFormat);
var aOutput = createVariable({prefix:"", force:true}, oatFormat);
var tOutput = createVariable({prefix:"", force:true}, oatFormat);

// output comment
function writeComment(text) {
  writeln(";" + text);
}

function onComment(message) {
  writeComment(message);
}

// print to display on controller
function println(text) {
  writeln('PRINT ' + '"' + text + '"')
}

function onOpen() {
  // control requires output only in mm
  unit = MM;

  setWordSeparator(",");

  if (programName) {
    println(programName)
  }

  var d = new Date();
  writeComment("creation date: " + d.toLocaleDateString() + " " + d.toLocaleTimeString());
}

var posCounter = 0;

function onLinear5D(x, y, z, a, b, c, feed) {
  var arrayName = 'pos[' + posCounter + ']';
  var xyzPos = xOutput.format(x) + '\t' + yOutput.format(y) + '\t' + zOutput.format(z);
  writeln(arrayName + '\t' + xyzPos + '\t0.0\t0.0\t0.0')
  posCounter += 1;
}

function onClose() {

}






