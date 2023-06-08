{
  description = "tfenv";

  inputs = {
    tfenv.url = "github:tfutils/tfenv";
    tfenv.flake = false;
  };
  outputs = { self, ... }@inputs:
    with inputs;
    {
      # Expose overlay to flake outputs, to allow using it from other flakes.
      # Flake inputs are passed to the overlay so that the packages defined in
      # it can use the sources pinned in flake.lock
      overlays.default = final: prev: (import ./overlays inputs) final prev;
    };
}
