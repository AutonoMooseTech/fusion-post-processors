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

capabilities = CAPABILITY_MILLING;
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

  setWordSeparator(" ");

  if (programName) {
    println(programName)
  }

  var d = new Date();
  writeComment("creation date: " + d.toLocaleDateString() + " " + d.toLocaleTimeString());
}

function getEulerAngle(vectorZ, angleInDegrees) {
  // X is rotated about standard XY-plane, not provided Z-axis
  var vectorX = Matrix.getZRotation(toRad(angleInDegrees)).transposed.multiply(new Vector(1, 0, 0));

  // X and Z form a non-orthogonal matrix, so cannot use standard matrix calculations
  var yAxis = Vector.cross(vectorZ, vectorX);
  var xAxis = Vector.cross(yAxis, vectorZ);
  var yAxis = Vector.cross(vectorZ, xAxis);

  m = new Matrix(xAxis, yAxis, vectorZ).transposed;

  if (getProperty("flipToolFrame")) {
    m = Matrix.getAxisRotation(new Vector(0, 1, 0), Math.PI).multiply(m);
  }

  ea = new Vector();
  var ea = m.transposed.getEuler2(EULER_ZYZ_R).toDeg();

  return ea;
}

var posCounter = 0;

// x,y,z is the tool position vector
// i,j,k is the tool axis vector
function onLinear5D(x, y, z, i, j, k, feed) {
  var arrayName = 'pos[' + posCounter + ']';

  var xyzPos = xOutput.format(x) + ' ' + yOutput.format(y) + ' ' + zOutput.format(z);
  
  var vAngle = new Vector(i, j, k);

  var ea = getEulerAngle(vAngle, 0);
  
  writeWords(arrayName,
    xOutput.format(x),
    yOutput.format(y),
    zOutput.format(z),
    oOutput.format(ea.x),
    aOutput.format(ea.y),
    tOutput.format(ea.z)
  )
  
  posCounter += 1;
}

function onClose() {

}






