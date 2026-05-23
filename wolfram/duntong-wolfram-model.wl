(* Duntong instrument-maker-v4.2 Wolfram packet source *)
ClearAll["Global`*"];

metadata = <|
  "PacketName" -> "Duntong Build Design",
  "Instrument" -> "Duntong",
  "Inventor" -> "Tony Koop",
  "GeneratedOn" -> "2026-05-06",
  "PrimaryModel" -> "CantileverBeam",
  "SecondaryModels" -> {"HelmholtzCavity", "StoppedPipe", "OpenPipe", "MembraneHybrid"},
  "A4" -> 440
|>;

packetDir = DirectoryName[$InputFileName /. "" -> NotebookDirectory[]];
familySpecPath = FileNameJoin[{packetDir, "..", "family-spec.csv"}];
validationPath = FileNameJoin[{packetDir, "..", "validation.csv"}];

familySpec = If[FileExistsQ[familySpecPath], Import[familySpecPath, "Dataset"], Dataset[{}]];
validationData = If[FileExistsQ[validationPath], Import[validationPath, "Dataset"], Dataset[{}]];

frequencyFromMidi[midi_, a4_: 440] := a4*2^((midi - 69)/12);
centsError[measured_, target_] := 1200*Log[2, measured/target];
cantileverFrequency[k_, thickness_, length_] := k*thickness/length^2;
cantileverLength[k_, thickness_, frequency_] := Sqrt[k*thickness/frequency];
helmholtzFrequency[area_, volume_, leff_, c_: 13552] := (c/(2*Pi))*Sqrt[area/(volume*leff)];
stoppedPipeFrequency[length_, c_: 13552] := c/(4*length);
openPipeFrequency[length_, c_: 13552] := c/(2*length);

duntongMedium = <|
  "Variant" -> "DNT-MEDIUM",
  "OuterDiameterIn" -> 12.0,
  "InnerDiameterIn" -> 11.0,
  "LengthIn" -> 16.0,
  "WallIn" -> 0.5,
  "TongueWidthIn" -> 1.5,
  "SlitWidthIn" -> 0.125,
  "TongueCount" -> 8,
  "RootMidi" -> 60,
  "K" -> 24438,
  "SpeedOfSoundInPerSec" -> 13552
|>;

pentatonicMinorOffsets = {0, 3, 5, 7, 8, 10, 12, 15};
noteNames = {"C4", "Eb4", "F4", "G4", "Ab4", "Bb4", "C5", "Eb5"};

tongueTable[params_] := Dataset[
  MapThread[
    <|
      "Note" -> #1,
      "Offset" -> #2,
      "Midi" -> params["RootMidi"] + #2,
      "TargetHz" -> N[frequencyFromMidi[params["RootMidi"] + #2]],
      "PredictedLengthIn" -> N[cantileverLength[params["K"], params["WallIn"], frequencyFromMidi[params["RootMidi"] + #2]]],
      "StartLongLengthIn" -> N[1.05*cantileverLength[params["K"], params["WallIn"], frequencyFromMidi[params["RootMidi"] + #2]]]
    |>&,
    {noteNames, pentatonicMinorOffsets}
  ]
];

mediumInternalVolume = Pi*(duntongMedium["InnerDiameterIn"]/2)^2*duntongMedium["LengthIn"];
mediumSlitArea = duntongMedium["TongueCount"]*(duntongMedium["SlitWidthIn"]*duntongMedium["TongueWidthIn"] + 2*duntongMedium["SlitWidthIn"]*3.0);
mediumHelmholtzHz = helmholtzFrequency[mediumSlitArea, mediumInternalVolume, duntongMedium["WallIn"], duntongMedium["SpeedOfSoundInPerSec"]];
mediumStoppedHz = stoppedPipeFrequency[duntongMedium["LengthIn"], duntongMedium["SpeedOfSoundInPerSec"]];
mediumOpenHz = openPipeFrequency[duntongMedium["LengthIn"], duntongMedium["SpeedOfSoundInPerSec"]];

modelExplorer = Manipulate[
  <|
    "TargetHz" -> targetHz,
    "TongueLengthIn" -> cantileverLength[k, thickness, targetHz],
    "FrequencyAtLengthHz" -> cantileverFrequency[k, thickness, length],
    "CentsAtLength" -> centsError[cantileverFrequency[k, thickness, length], targetHz],
    "HelmholtzHz" -> helmholtzFrequency[slitArea, volume, neckLength],
    "CoupledQ" -> Abs[helmholtzFrequency[slitArea, volume, neckLength]/targetHz - 1] <= 0.2
  |>,
  {{targetHz, 261.63, "target Hz"}, 100, 900},
  {{k, 24438, "K"}, 20000, 30000},
  {{thickness, 0.5, "thickness in"}, 0.25, 0.75},
  {{length, 6.834, "test length in"}, 3, 9},
  {{slitArea, mediumSlitArea, "slit area in^2"}, 0.5, 10},
  {{volume, mediumInternalVolume, "volume in^3"}, 200, 1800},
  {{neckLength, 0.5, "neck length in"}, 0.125, 1.5}
];

validationRows = Normal[validationData];
validationPlot = Quiet@Check[
  ListPlot[
    DeleteMissing[ToExpression /@ Lookup[validationRows, "cents_error", Missing[]]],
    PlotTheme -> "Scientific",
    Frame -> True,
    FrameLabel -> {{"Cents error", None}, {"Measurement row", "Duntong validation"}}
  ],
  "No numeric cents-error values yet."
];

audioPreview[f_: 261.63, seconds_: 1.5] := AudioNormalize[
  AudioAdd[
    AudioGenerator[{"Sin", f}, seconds],
    0.35 AudioGenerator[{"Sin", 2 f}, seconds],
    0.18 AudioGenerator[{"Sin", 3 f}, seconds]
  ]
];

packetNotebook[] := CreateDocument[
  {
    TextCell["Duntong Original Cylindrical Tongue Drum", "Title"],
    TextCell["Cantilever tongue model plus body-cavity exploration", "Subtitle"],
    TextCell["Metadata", "Section"],
    ExpressionCell[metadata, "Input"],
    TextCell["Medium Tongue Predictions", "Section"],
    ExpressionCell[tongueTable[duntongMedium], "Input"],
    TextCell["Body Coupling First Pass", "Section"],
    ExpressionCell[<|
      "InternalVolumeIn3" -> N[mediumInternalVolume],
      "SlitAreaIn2" -> N[mediumSlitArea],
      "HelmholtzHz" -> N[mediumHelmholtzHz],
      "StoppedPipeHz" -> N[mediumStoppedHz],
      "OpenPipeHz" -> N[mediumOpenHz],
      "WorkbookNoteConflict" -> "design.md records workbook prose note of 135 Hz as TBD"
    |>, "Input"],
    TextCell["Interactive Explorer", "Section"],
    ExpressionCell[modelExplorer, "Input"],
    TextCell["Audio Preview", "Section"],
    ExpressionCell[audioPreview[261.63], "Input"],
    TextCell["Validation Plot", "Section"],
    ExpressionCell[validationPlot, "Input"]
  },
  WindowTitle -> "Duntong Model"
];

packetNotebook[];
