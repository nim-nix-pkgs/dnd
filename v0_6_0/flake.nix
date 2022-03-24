{
  description = ''Drag and drop source / target'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-dnd-v0_6_0.flake = false;
  inputs.src-dnd-v0_6_0.ref   = "refs/tags/v0.6.0";
  inputs.src-dnd-v0_6_0.owner = "adokitkat";
  inputs.src-dnd-v0_6_0.repo  = "dnd";
  inputs.src-dnd-v0_6_0.type  = "github";
  
  inputs."gintro".owner = "nim-nix-pkgs";
  inputs."gintro".ref   = "master";
  inputs."gintro".repo  = "gintro";
  inputs."gintro".dir   = "v0_9_7";
  inputs."gintro".type  = "github";
  inputs."gintro".inputs.nixpkgs.follows = "nixpkgs";
  inputs."gintro".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-dnd-v0_6_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-dnd-v0_6_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}