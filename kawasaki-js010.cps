/**
  Copyright (C) 2012-2021 by Autodesk, Inc.
  All rights reserved.

  KUKA KRL post processor configuration.

  $Revision: 43470 147f5cf60e9217cf9c3365dc511a0f631d89bb16 $
  $Date: 2021-10-13 20:53:32 $

  FORKID {E86D1E53-6B40-4EEB-A94E-552C25F118A4}
*/

///////////////////////////////////////////////////////////////////////////////
//     CUSTOM NC COMMANDS - search for 'Machine specific output, modify as needed'
//
//     endEffectorCommandOn   - Modify this variable to define the commands to turn ON the end effector, if needed
//     endEffectorCommandOff  - Modify this variable to define the commands to turn OFF the end effector, if needed
//
///////////////////////////////////////////////////////////////////////////////

description = "KUKA Robotics - KRL";
vendor = "KUKA";
vendorUrl = "http://www.kuka.com";
legal = "Copyright (C) 2012-2021 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 45702;

longDescription = "Generic KUKA KRL post. Please refer to the User Guide for programming specification and sample. Always validate with KUKA.Sim before loading any toolpath on your Robot.";

extension = "src";
programNameIsInteger = false;
setCodePage("ascii");

capabilities = CAPABILITY_MILLING | CAPABILITY_ADDITIVE;
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

properties = {
  flipToolFrame: {
    title      : "Flip tool frame",
    description: "Flip the tool frame (Z- is along the tool axis).",
    group      : "parameters",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  firstPointType: {
    title      : "First point move type",
    description: "Set if the first point is defined by joint angles (joints values are needed but arm configuration can be ignored) or using cartesian coordinates (robot arm configuration data are required but joints value can be ignored).",
    group      : "configuration",
    type       : "enum",
    values     : [
      {title:"Cartesian", id:"Cartesian"},
      {title:"Joints", id:"Joints"}
    ],
    value: "Joints",
    scope: "post"
  },
  useSubfolder: {
    title      : "Use subfolder",
    description: "Specifies if files should be saved in subfolder or not.",
    group      : "general",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  useCoolant: {
    title      : "Use coolant",
    description: "Specifies if Robot needs Coolant Codes",
    group      : "general",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  nameLimitation: {
    title      : "Toolpath name length limitation",
    description: "Check if each toolpath name has max 30 characters.",
    group      : "general",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  robotStartJ1: {
    title      : "Robot joint 1",
    description: "KUKA robot joint value used for the initial position point before LIN start.",
    group      : "configuration",
    type       : "number",
    value      : 5,
    scope      : "post"
  },
  robotStartJ2: {
    title      : "Robot joint 2",
    description: "KUKA robot joint value used for the initial position point before LIN start.",
    group      : "configuration",
    type       : "number",
    value      : -80,
    scope      : "post"
  },
  robotStartJ3: {
    title      : "Robot joint 3",
    description: "KUKA robot joint value used for the initial position point before LIN start.",
    group      : "configuration",
    type       : "number",
    value      : 100,
    scope      : "post"
  },
  robotStartJ4: {
    title      : "Robot joint 4",
    description: "KUKA robot joint value used for the initial position point before LIN start.",
    group      : "configuration",
    type       : "number",
    value      : 75,
    scope      : "post"
  },
  robotStartJ5: {
    title      : "Robot joint 5",
    description: "KUKA robot joint value used for the initial position point before LIN start.",
    group      : "configuration",
    type       : "number",
    value      : -60,
    scope      : "post"
  },
  robotStartJ6: {
    title      : "Robot joint 6",
    description: "KUKA robot joint value used for the initial position point before LIN start.",
    group      : "configuration",
    type       : "number",
    value      : -65,
    scope      : "post"
  },
  robotStatus: {
    title      : "Robot 'Status' configuration",
    description: "KUKA robot 'Status' configuration",
    group      : "configuration",
    type       : "string",
    value      : "B110",
    scope      : "post"
  },
  robotTurn: {
    title      : "Robot 'Turn' configuration",
    description: "KUKA robot 'Turn' configuration",
    group      : "configuration",
    type       : "string",
    value      : "B110010",
    scope      : "post"
  },
  robotHeadAngle: {
    title      : "Robot head angle",
    description: "KUKA robot head angle around tool axis (A)",
    group      : "process",
    type       : "number",
    value      : 30,
    scope      : "post"
  },
  robotSmoothing: {
    title      : "Robot path smoothing (APO.CDIS) (mm)",
    description: "KUKA robot path smoothing APO.CDIS (mm)",
    group      : "parameters",
    type       : "integer",
    value      : 2,
    scope      : "post"
  },
  robotPTPVelocity: {
    title      : "Robot PTP velocity (%)",
    description: "KUKA robot PTP velocity (%)",
    group      : "parameters",
    type       : "enum",
    values     : [
      {title:"5", id:"5"},
      {title:"10", id:"10"},
      {title:"15", id:"15"},
      {title:"20", id:"20"},
      {title:"25", id:"25"},
      {title:"50", id:"50"},
      {title:"75", id:"75"},
      {title:"100", id:"100"}
    ],
    value: "25",
    scope: "post"
  },
  robotAcceleration: {
    title      : "Robot acceleration/deceleration (%)",
    description: "KUKA robot acceleration/deceleration (%)",
    group      : "parameters",
    type       : "enum",
    values     : [
      {title:"5", id:"5"},
      {title:"10", id:"10"},
      {title:"15", id:"15"},
      {title:"20", id:"20"},
      {title:"25", id:"25"},
      {title:"50", id:"50"},
      {title:"75", id:"75"},
      {title:"100", id:"100"}
    ],
    value: "20",
    scope: "post"
  },
  robotAdvance: {
    title      : "Robot look-ahead (ADVANCE)",
    description: "KUKA look-ahead (ADVANCE)",
    group      : "parameters",
    type       : "enum",
    values     : [
      {title:"1", id:"1"},
      {title:"3", id:"3"},
      {title:"5", id:"5"}
    ],
    value: "3",
    scope: "post"
  },
  writeDateAndTime: {
    title      : "Write date and time",
    description: "Output date and time in the header of the code.",
    group      : "general",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  endEffectorBehavior: {
    title      : "End-effector state",
    description: "Set the end-effector state (including behavior during flat toolpath transitions).",
    group      : "process",
    type       : "enum",
    values     : [
      {title:"OFF", id:"Off"},
      {title:"ON + links ON", id:"On"},
      {title:"ON + links OFF", id:"OnOff"}
    ],
    value: "Off",
    scope: "post"
  },
  robotToolData: {
    title      : "Robot tool data",
    description: "KUKA tool data (TOOL_DATA) used for FFF toolpath",
    group      : "fff",
    type       : "integer",
    value      : 1,
    scope      : "post"
  },
  robotBaseData: {
    title      : "Robot base data",
    description: "KUKA base data (BASE_DATA) used for FFF toolpath",
    group      : "fff",
    type       : "integer",
    value      : 1,
    scope      : "post"
  }
};
groupDefinitions = {
  process      : {title:"Process", description:"Process post settings", order:0},
  configuration: {title:"Configuration", description:"General robot configuration", order:1},
  parameters   : {title:"Parameters", description:"Robot parameters", order:2},
  fff          : {title:"FFF Settings", description:"FFF Settings", collapsed:true, order:3},
  general      : {title:"General", description:"Other post options", collapsed:true, order:4}
};

var singleLineCoolant = false; // specifies to output multiple coolant codes in one line rather than in separate lines
// samples:
// {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
// {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
// {id: COOLANT_THROUGH_TOOL, on: "M88 P3 (myComment)", off: "M89"}
var coolants = [
  {id:COOLANT_FLOOD},
  {id:COOLANT_MIST},
  {id:COOLANT_THROUGH_TOOL},
  {id:COOLANT_AIR},
  {id:COOLANT_AIR_THROUGH_TOOL},
  {id:COOLANT_SUCTION},
  {id:COOLANT_FLOOD_MIST},
  {id:COOLANT_FLOOD_THROUGH_TOOL},
  {id:COOLANT_OFF}
];

var xyzFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true, trim:false});
var abcFormat = createFormat({decimals:3, forceDecimal:true, trim:false});
var jointFormat = createFormat({decimals:4, forceDecimal:false});
var feedFormat = createFormat({decimals:(unit == MM ? 2 : 3), forceDecimal:false, scale:1.0 / 1000.0 / 60.0}); // mm/min -> m/s
var toolFormat = createFormat({decimals:0});
var rpmFormat = createFormat({decimals:0});
var secFormat = createFormat({decimals:3}); // seconds
var taperFormat = createFormat({decimals:1, scale:DEG});

var xOutput = createVariable({prefix:"X ", force:true}, xyzFormat);
var yOutput = createVariable({prefix:"Y ", force:true}, xyzFormat);
var zOutput = createVariable({onchange:function () {retracted = false;}, prefix:"Z ", force:true}, xyzFormat);
var aOutput = createVariable({prefix:"A ", force:true}, abcFormat);
var bOutput = createVariable({prefix:"B ", force:true}, abcFormat);
var cOutput = createVariable({prefix:"C ", force:true}, abcFormat);
var feedOutput = createVariable({prefix:"$VEL.CP="}, feedFormat);
var sOutput = createVariable({prefix:"", force:true}, rpmFormat);

var currentWorkOffset;
var forceSpindleSpeed = false;
var retracted = false; // specifies that the tool has been retracted to the safe plane
var firstLin = true; // set during onSection to reset first toolpath point
var pendingRadiusCompensation = -1;
var endEffectorState = 0; // initial state of the end effector (0 =off)

// Machine specific output, modify as needed
var endEffectorCommandOn = "==> END EFFECTOR ON: PUT YOUR CODE HERE IN THE POST"; // specifies the command to turn on the end effector
var endEffectorCommandOff = "==> END EFFECTOR OFF: PUT YOUR CODE HERE IN THE POST";  // specifies the command to turn off the end effector

var subfolderPath;
var subNames = new Array();
var toolpathNames = new Array();
var permittedCommentChars = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,;:=_-+'#$&%/()[]{}";

/**
  Writes the specified block.
*/
function writeBlock() {
  writeWords(arguments);
}

/**
  Formats a comment.
*/
function formatComment(text) {
  return ";" + filterText(String(text), permittedCommentChars).replace();
}

/**
  Output a comment.
*/
function writeComment(text) {
  writeln(formatComment(text));
}

function onOpen() {
  // Machine requires output only in MM
  unit = MM;
  setWordSeparator(",");

  // create subfolder if requested
  if (getProperty("useSubfolder")) {
    subfolderPath = FileSystem.getCombinedPath(FileSystem.getFolderPath(getOutputPath()), programName);
    if (!FileSystem.isFolder(subfolderPath)) {
      FileSystem.makeFolder(subfolderPath);
    }
  }

  writeBlock("&ACCESS RVO");
  writeBlock("DEF " + FileSystem.replaceExtension(FileSystem.getFilename(getOutputPath().toUpperCase()), "") + "()");

  writeComment("FOLD INI");
  writeln("  " + formatComment("FOLD BASISTECH INI"));

  writeBlock("    GLOBAL INTERRUPT DECL 3 WHEN $STOPMESS==TRUE DO IR_STOPM ( )");
  writeBlock("    INTERRUPT ON 3");
  writeBlock("    BAS (#INITMOV,0 )");

  writeln("  " + formatComment("ENDFOLD (BASISTECH INI)"));
  writeln("  " + formatComment("FOLD USER INI"));
  writeln("  " + formatComment("Make your modifications here"));
  if (programComment) {
    writeComment(programComment);
  }
  writeln("");
  writeln("  " + formatComment("ENDFOLD (USER INI)"));
  writeComment("ENDFOLD (INI)");
  writeln("");
  if (hasGlobalParameter("generated-by")) {
    var value = getGlobalParameter("generated-by");
    writeComment(" Generated by AUTODESK " + value);
  }
  if (getProperty("writeDateAndTime")) {
    var d = new Date();
    writeComment(" Creation date: " + d.toLocaleDateString() + " " + d.toLocaleTimeString());
  }
  writeln("");
  writeComment(" Set PTP velocity and acceleration");
  writeln("$VEL_AXIS[1] = " + getProperty("robotPTPVelocity"));
  writeln("$VEL_AXIS[2] = " + getProperty("robotPTPVelocity"));
  writeln("$VEL_AXIS[3] = " + getProperty("robotPTPVelocity"));
  writeln("$VEL_AXIS[4] = " + getProperty("robotPTPVelocity"));
  writeln("$VEL_AXIS[5] = " + getProperty("robotPTPVelocity"));
  writeln("$VEL_AXIS[6] = " + getProperty("robotPTPVelocity"));
  writeln("$ACC_AXIS[1] = " + getProperty("robotAcceleration"));
  writeln("$ACC_AXIS[2] = " + getProperty("robotAcceleration"));
  writeln("$ACC_AXIS[3] = " + getProperty("robotAcceleration"));
  writeln("$ACC_AXIS[4] = " + getProperty("robotAcceleration"));
  writeln("$ACC_AXIS[5] = " + getProperty("robotAcceleration"));
  writeln("$ACC_AXIS[6] = " + getProperty("robotAcceleration"));
  writeln("");
  writeComment(" To set 'Tool On Robot' Mode");
  writeBlock("$IPO_MODE = #BASE");
  writeln("");
  writeComment(" Set smoothing value");
  writeBlock("$APO.CDIS = " + getProperty("robotSmoothing"));
  writeln("");
  writeComment(" Set $ADVANCE value (number of points read in advance)");
  writeBlock("$ADVANCE = " + getProperty("robotAdvance"));
  writeln("");
  writeComment(" Set BASE");

  if (getSection(0).type == TYPE_ADDITIVE && getSection(0).getTool().type == TOOL_MARKER) {
    // if it is an FFF operation
    writeBlock("$BASE = BASE_DATA[" + getProperty("robotBaseData") + "]");
    currentWorkOffset = getProperty("robotBaseData");
  } else {
    if (getSection(0).workOffset == 0) {
      error(localize("Active BASE has not been specified. Define it as a WCS value in the current Setup."));
    } else {
      writeBlock("$BASE = BASE_DATA[" + getSection(0).workOffset + "]");
      currentWorkOffset = getSection(0).workOffset;
    }
    // set coolant code if needed in subtractive
    setCoolant(tool.coolant);
  }
}

function onComment(message) {
  writeComment(message);
}

/**
  Writes the right robot move (first point PTP, others as LIN)
*/
function writeRobotMove(x, y, z, i, j, k, feed) {
  if (firstLin) {
    if (getProperty("firstPointType") == "Joints") {
      writeJoints(getProperty("robotStartJ1"), getProperty("robotStartJ2"), getProperty("robotStartJ3"), getProperty("robotStartJ4"), getProperty("robotStartJ5"), getProperty("robotStartJ6"));
      writeLIN(x, y, z, i, j, k, getProperty("robotHeadAngle"), feed);
    } else {
      writePTP(x, y, z, i, j, k, getProperty("robotHeadAngle"), getProperty("robotStatus"), getProperty("robotTurn"));
    }
    firstLin = false;
  } else {
    writeLIN(x, y, z, i, j, k, getProperty("robotHeadAngle"), feed);
  }
}

/**
  Move using joints
*/
function writeJoints(j1, j2, j3, j4, j5, j6) {
  writeBlock("PTP {A1 " + jointFormat.format(j1),
    "A2 " + jointFormat.format(j2),
    "A3 " + jointFormat.format(j3),
    "A4 " + jointFormat.format(j4),
    "A5 " + jointFormat.format(j5),
    "A6 " + jointFormat.format(j6),
    "E1 0,E2 0,E3 0,E4 0,E5 0,E6 0}");
}

/**
  PTP move
*/
function writePTP(x, y, z, i, j, k, angle, s, t) {
  var vz = new Vector();

  vz.x = i;
  vz.y = j;
  vz.z = k;
  var ea = getKUKAEulerAngleFromVectorAndRotationAngle(vz, angle);
  // check status and turn format
  var status = s;
  var turn = t;

  if (status.indexOf("B") != -1) {
    if (status.indexOf("'") != 0) {
      status = "'" + status;
    }
    if (status.lastIndexOf("'") != status.length - 1) {
      status += "'";
    }
  }
  if (turn.indexOf("B") != -1) {
    if (turn.indexOf("'") != 0) {
      turn = "'" + turn;
    }
    if (turn.lastIndexOf("'") != turn.length - 1) {
      turn += "'";
    }
  }

  // write the move
  writeBlock("PTP {" + xOutput.format(x),
    yOutput.format(y),
    zOutput.format(z),
    aOutput.format(ea.x),
    bOutput.format(ea.y),
    cOutput.format(ea.z),
    "E1 0,E2 0,E3 0,E4 0,E5 0,E6 0,S" + status,
    "T" + turn + "}");
}

function writeLIN(x, y, z, i, j, k, angle, feed) {
  writeBlock(feedOutput.format(feed));
  var vz = new Vector();

  vz.x = i;
  vz.y = j;
  vz.z = k;
  var ea = getKUKAEulerAngleFromVectorAndRotationAngle(vz, angle);
  writeBlock("LIN {" + xOutput.format(x),
    yOutput.format(y),
    zOutput.format(z),
    aOutput.format(ea.x),
    bOutput.format(ea.y),
    cOutput.format(ea.z) + "} C_DIS");
}

var operationCounter = 0;
function onSection() {
  firstLin = true;
  cancelRotation();
  if (!currentSection.isMultiAxis())  {
    setRotation(currentSection.workPlane);
  }

  var insertToolCall = isFirstSection() || currentSection.getForceToolChange && currentSection.getForceToolChange() ||
  (tool.number != getPreviousSection().getTool().number);

  var counter = 1;
  var opName;
  if (isFFFOperation(currentSection)) {
    opName = (programName + "_" + counter);
    counter = counter++;
  } else {
    if (hasParameter("operation-comment")) {
      opName = getParameter("operation-comment");
    } else if (hasParameter("notes")) {
      opName = getParameter("notes");
    } else {
      opName = ("unnamed_" + counter);
      counter = counter++;
    }
  }

  opName = "s" + opName.replace(/[^a-zA-Z0-9_()+]/g, "_");

  if (getProperty("useSubfolder")) {
    folder = subfolderPath;
  } else {
    folder = FileSystem.getFolderPath(getOutputPath());
  }

  // write toolpath name in Array to check for duplicated names
  if (toolpathNames.length > 0 && toolpathNames.indexOf(opName) > -1) {
    ++operationCounter;
    opName += "_" + operationCounter;
  }
  toolpathNames.push(opName);

  if (getProperty("nameLimitation")) {
    if (opName.length > 30) {
      error(subst(localize("Toolpath Name '%1' is longer than 30 characters. Please modify it to less than 30 characters."), opName));
    }
  }

  var path = FileSystem.getCombinedPath(folder, opName + ".src");

  var workOffsetLocal = isFFFOperation(currentSection) ? getProperty("robotBaseData") : currentSection.workOffset;
  if (currentWorkOffset != workOffsetLocal) {
    if (workOffsetLocal == 0) {
      error(localize("Active BASE has not been specified. Define it as WCS value, editing current Setup."));
    } else {
      writeln("");
      writeComment(" Set BASE");
      writeBlock("$BASE = BASE_DATA[" + workOffsetLocal + "]");
      currentWorkOffset = workOffsetLocal;
    }
  }

  var toolNumber = isFFFOperation(currentSection) ? getProperty("robotToolData") : tool.number;

  if (insertToolCall) {
    writeln("");
    writeComment(" Load Tool");
    writeComment("TOOL_CHANGE(" + toolFormat.format(toolNumber) + ")");
    writeln("");
    writeComment(" Set Tool");
    writeBlock("BAS(#TOOL," + toolFormat.format(toolNumber) + ")");
    writeBlock("$TOOL = TOOL_DATA[" + toolFormat.format(toolNumber) + "]");
    writeln("");
    if (isFirstSection() || (rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent()))) {
      writeComment(" Spindle ON/speed");
      writeComment("SPINDLE_ON(" + sOutput.format(spindleSpeed) + ")");
      writeln("");
    }
  }

  // write toolpath name in main program
  // load toolpath name in subNames array to be written later in progname.dat file
  writeBlock(opName + "()");
  subNames.push(opName);

  redirectToFile(path);
  writeBlock("&ACCESS RVO");
  writeBlock("DEF " + opName + "()");

  if (hasGlobalParameter("generated-by")) {
    var value = getGlobalParameter("generated-by");
    writeComment(" Generated by AUTODESK " + value);
  }
  if (getProperty("writeDateAndTime")) {
    var d = new Date();
    writeComment(" Creation date: " + d.toLocaleDateString() + " " + d.toLocaleTimeString());
  }

  writeComment("FOLD " + opName);
  writeComment(" Start position (joint) = {A1 " + getProperty("robotStartJ1") +
    ",A2 " + getProperty("robotStartJ2") + ",A3 " + getProperty("robotStartJ3") +
    ",A4 " + getProperty("robotStartJ4") + ",A5 " + getProperty("robotStartJ5") +
    ",A6 " + getProperty("robotStartJ6") + "}");
  writeComment(" Tool Number            = " + toolFormat.format(tool.number));
  writeComment(" Base Number            = " + currentWorkOffset);
  onSpindleSpeed(spindleSpeed);
  writeComment(" Program file name      = " + opName + ".src");
  writeln("");
}

function onDwell(seconds) {
}

function onSpindleSpeed(spindleSpeed) {
  writeComment(" Spindle Speed          = " + sOutput.format(spindleSpeed) + " RPM");
}

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

function onRapid(_x, _y, _z) {
  if (isFFFOperation(currentSection)) {
    // for FFF: managing extruder on/off from here instead of onMovement()
    setAdditiveProcessOFF();
  }
  var workPlane = currentSection.workPlane.forward;
  writeRobotMove(_x, _y, _z, workPlane.x, workPlane.y, workPlane.z, highFeedrate);
}

function onLinear(_x, _y, _z, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode is not supported by robot."));
    return;
  }
  var workPlane = currentSection.workPlane.forward;
  writeRobotMove(_x, _y, _z, workPlane.x, workPlane.y, workPlane.z, feed);
}

function onLinearExtrude(_x, _y, _z, feed) {
  if (isFFFOperation(currentSection)) {
    // for FFF: managing extruder on/off from here instead of onMovement()
    setAdditiveProcessON();
  }
  var workPlane = currentSection.workPlane.forward;
  writeRobotMove(_x, _y, _z, workPlane.x, workPlane.y, workPlane.z, feed);
}

function onRapid5D(_x, _y, _z, _i, _j, _k) {
  writeRobotMove(_x, _y, _z,  _i, _j, _k, highFeedrate);
}

function onLinear5D(_x, _y, _z, _i, _j, _k, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode is not supported by robot."));
    return;
  }
  writeRobotMove(_x, _y, _z, _i, _j, _k, feed);
}

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  linearize(tolerance);
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    if (singleLineCoolant) {
      writeBlock(coolantCodes.join(getWordSeparator()));
    } else {
      for (var c in coolantCodes) {
        writeBlock(coolantCodes[c]);
      }
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant) {
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if ((getProperty("useCoolant") != undefined) && !getProperty("useCoolant")) {
    return undefined;
  }
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (tool.type == TOOL_PROBE) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode) {
    return undefined; // coolant is already active
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined)) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(coolantOff[i]);
      }
    } else {
      multipleCoolantBlocks.push(coolantOff);
    }
  }

  var m;
  var coolantCodes = {};
  for (var c in coolants) { // find required coolant codes into the coolants array
    if (coolants[c].id == coolant) {
      coolantCodes.on = coolants[c].on;
      if (coolants[c].off != undefined) {
        coolantCodes.off = coolants[c].off;
        break;
      } else {
        for (var i in coolants) {
          if (coolants[i].id == COOLANT_OFF) {
            coolantCodes.off = coolants[i].off;
            break;
          }
        }
      }
    }
  }
  if (coolant == COOLANT_OFF) {
    m = !coolantOff ? coolantCodes.off : coolantOff; // use the default coolant off command when an 'off' value is not specified
  } else {
    coolantOff = coolantCodes.off;
    m = coolantCodes.on;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  } else {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(m[i]);
      }
    } else {
      multipleCoolantBlocks.push(m);
    }
    currentCoolantMode = coolant;
    for (var i in multipleCoolantBlocks) {
      if (typeof multipleCoolantBlocks[i] == "number") {
        multipleCoolantBlocks[i] = mFormat.format(multipleCoolantBlocks[i]);
      }
    }
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

function isFFFOperation(section) {
  return section.getType() == TYPE_ADDITIVE && section.getTool().type == TOOL_MARKER;
}

function onMovement(movement) {
  // We can use a simple milling (subtractive) toolpaths as additive :
  // ignore all the onMovement stuff for FFF since the end effector switch
  // is handled in the onRapid and onLinearExtrude functions

  if (!isFFFOperation(currentSection)) {
    switch (movement) {
    case MOVEMENT_CUTTING:
    case MOVEMENT_FINISH_CUTTING:
      writeComment(" Cutting Move Starts");
      setAdditiveProcessON();
      break;
    case MOVEMENT_PLUNGE:
      writeComment(" Plunge Move Starts");
      break;
    case MOVEMENT_LEAD_IN:
      writeComment(" Lead In Move Starts");
      break;
    case MOVEMENT_LEAD_OUT:
      writeComment(" Lead Out Move Starts");
      setAdditiveProcessOFF();
      break;
    case MOVEMENT_LINK_TRANSITION:
      writeComment(" Link Move Starts");
      if (getProperty("endEffectorBehavior") == "OnOff") {
        setAdditiveProcessOFF();
      }
      break;
    case MOVEMENT_BRIDGING:
      writeComment(" Bridging Move Starts");
      break;
    case MOVEMENT_LINK_DIRECT:
      writeComment(" Cutting Move Ends");
      break;
    case MOVEMENT_RAPID:
      writeComment(" Rapid Move Starts");
      setAdditiveProcessOFF();
      break;
    }
  }
}

//  An end-effector is the device at the end of a robotic arm.
//  It may consist in different gripper/tool/etc. and the activation/deactivation code depends on the end-effector type.
//  These codes are to be customized by integrator and/or end-user.

function setAdditiveProcessON() {
  if (getProperty("endEffectorBehavior") != "Off" && endEffectorState == 0) {
    writeComment(endEffectorCommandOn);
    endEffectorState = 1;
  }
}

function setAdditiveProcessOFF() {
  if (getProperty("endEffectorBehavior") != "Off" && endEffectorState == 1) {
    writeComment(endEffectorCommandOff);
    endEffectorState = 0;
  }
}

function onCommand(command) {
  switch (command) {
  case COMMAND_STOP:
    writeBlock("HALT");
    forceSpindleSpeed = true;
    return;
  case COMMAND_OPTIONAL_STOP:
    writeComment("WAIT FOR $IN[1]"); // need variable
    return;
  case COMMAND_COOLANT_ON:
    setCoolant(COOLANT_FLOOD);
    return;
  case COMMAND_COOLANT_OFF:
    setCoolant(COOLANT_OFF);
    return;
  case COMMAND_START_SPINDLE:
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    return;
  case COMMAND_BREAK_CONTROL:
    return;
  case COMMAND_TOOL_MEASURE:
    return;
  default:
    onUnsupportedCommand(command);
  }
}

function onSectionEnd() {
  writeComment("ENDFOLD");
  writeBlock("END");
  closeRedirection();
}

function writeMainDat() {
  if (getProperty("useSubfolder")) {
    folder = subfolderPath;
    var path = FileSystem.getCombinedPath(folder, programName + ".dat");
  } else {
    var path = FileSystem.getCombinedPath(FileSystem.getFolderPath(getOutputPath()), programName + ".dat");
  }
  redirectToFile(path);
  writeBlock("&ACCESS RVO");
  writeBlock("DEFDAT " + programName);

  writeComment("FOLD EXTERNAL DECLARATIONS;%{PE}%MKUKATPBASIS,%CEXT,%VCOMMON,%P");
  writeln("  " + formatComment("FOLD BASISTECH EXT;%{PE}%MKUKATPBASIS,%CEXT,%VEXT,%P"));
  writeBlock("    EXT  BAS (BAS_COMMAND  :IN,REAL  :IN )");
  writeln("  " + formatComment("ENDFOLD (BASISTECH EXT)"));
  writeln("");
  for (var i = 0; i < subNames.length; ++i) {
    writeBlock("  EXT " + subNames[i] + "()");
  }
  writeln("");
  writeComment("ENDFOLD (EXTERNAL DECLARATIONS)");
  writeBlock("ENDDAT");
  closeRedirection();
  return;
}

function writeSubDat() {
  for (var i = 0; i < subNames.length; ++i) {
    var opName = subNames[i];
    if (getProperty("useSubfolder")) {
      folder = subfolderPath;
      var path = FileSystem.getCombinedPath(folder, opName + ".dat");
    } else {
      var path = FileSystem.getCombinedPath(FileSystem.getFolderPath(getOutputPath()), opName + ".dat");
    }
    redirectToFile(path);
    writeBlock("&ACCESS RVO");
    writeBlock("DEFDAT " + opName);

    writeComment("FOLD EXTERNAL DECLARATIONS;%{PE}%MKUKATPBASIS,%CEXT,%VCOMMON,%P");
    writeln("  " + formatComment("FOLD BASISTECH EXT;%{PE}%MKUKATPBASIS,%CEXT,%VEXT,%P"));
    writeBlock("    EXT  BAS (BAS_COMMAND  :IN,REAL  :IN )");
    writeln("  " + formatComment("ENDFOLD (BASISTECH EXT)"));
    writeln("");
    writeComment("ENDFOLD (EXTERNAL DECLARATIONS)");
    writeBlock("ENDDAT");
    closeRedirection();
  }
  return;
}

/**
  converts a vectorZ and a rotation angle around it to KUKA Euler angles
*/
function getKUKAEulerAngleFromVectorAndRotationAngle(vectorZ, angleInDegrees) {
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
  var ea = m.transposed.getEuler2(EULER_ZYX_R).toDeg();

  return ea;
}

function onClose() {
  writeln("");
  writeComment(" Spindle OFF");
  writeComment("SPINDLE_OFF()");
  writeln("");
  writeBlock("END");
  writeMainDat();
  writeSubDat();
}

/**
 moves main program to subfolder if requested
*/
function onTerminate() {
  if (getProperty("useSubfolder")) {
    var outputPath = getOutputPath();
    var programFilename = FileSystem.getFilename(outputPath);
    var newFolder = subfolderPath + "\\" + programFilename;
    FileSystem.copyFile(outputPath, newFolder);
    FileSystem.remove(outputPath);

    var file = new TextFile(FileSystem.getFolderPath(getOutputPath()) + "\\" + programFilename, true, "ansi");
    file.writeln("This is a dummy file.");
    file.writeln("Your program files are located here: " + subfolderPath);
    file.close();
  }
}

function setProperty(property, value) {
  properties[property].current = value;
}
