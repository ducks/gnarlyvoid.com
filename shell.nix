{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    zola
  ];

  shellHook = ''
    echo "Gnarly Void development environment"
    echo "Zola version: $(zola --version)"
    echo ""
    echo "Available commands:"
    echo "  make void   - Create a new void"
    echo "  make serve  - Start local development server"
    echo "  make build  - Build the site"
    echo "  make clean  - Clean build artifacts"
  '';
}
