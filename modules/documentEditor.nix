{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Conversion tools
    poppler-utils # gives you `pdftotext`, `pdftohtml`, etc.
    python3Packages.pdf2docx # pdf → docx converter
    pandoc # docx ↔ markdown ↔ pdf
    libreoffice # fallback for complex conversions

    # PDF rebuild
    texlive.combined.scheme-full # LaTeX stack if you want pandoc → PDF via LaTeX
  ];

}
