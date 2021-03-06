{
  description = ''Drag and drop source / target'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-dnd-master.flake = false;
  inputs.src-dnd-master.ref   = "refs/heads/master";
  inputs.src-dnd-master.owner = "adokitkat";
  inputs.src-dnd-master.repo  = "dnd";
  inputs.src-dnd-master.type  = "github";
  
  inputs."gintro".owner = "nim-nix-pkgs";
  inputs."gintro".ref   = "master";
  inputs."gintro".repo  = "gintro";
  inputs."gintro".dir   = "v0_9_9";
  inputs."gintro".type  = "github";
  inputs."gintro".inputs.nixpkgs.follows = "nixpkgs";
  inputs."gintro".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-dnd-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-dnd-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}