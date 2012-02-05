" This plugin was taken from:
" https://gist.github.com/1335465
"
" Copy this in ~/.vim/plugins
" In normal mode, type “,gaalpha” to append α, or “,gibeta” to insert β

function DefineGreekLetter(name, letter)
  exec "nmap ,gi" . a:name . " i". a:letter
  exec "nmap ,ga" . a:name . " a". a:letter
endf

call DefineGreekLetter("alpha", "α")
call DefineGreekLetter("Alpha", "Α")
call DefineGreekLetter("beta", "β")
call DefineGreekLetter("Beta", "Β")
call DefineGreekLetter("gamma", "γ")
call DefineGreekLetter("Gamma", "Γ")
call DefineGreekLetter("delta", "δ")
call DefineGreekLetter("Delta", "Δ")
call DefineGreekLetter("epsilon", "ε")
call DefineGreekLetter("Epsilon", "Ε")
call DefineGreekLetter("zeta", "ζ")
call DefineGreekLetter("Zeta", "Ζ")
call DefineGreekLetter("eta", "η")
call DefineGreekLetter("Eta", "Η")
call DefineGreekLetter("theta", "θ")
call DefineGreekLetter("Theta", "Θ")
call DefineGreekLetter("iota", "ι")
call DefineGreekLetter("Iota", "Ι")
call DefineGreekLetter("kappa", "κ")
call DefineGreekLetter("Kappa", "Κ")
call DefineGreekLetter("lambda", "λ")
call DefineGreekLetter("Lambda", "Λ")
call DefineGreekLetter("mu", "μ")
call DefineGreekLetter("Mu", "Μ")
call DefineGreekLetter("nu", "ν")
call DefineGreekLetter("Nu", "Ν")
call DefineGreekLetter("xi", "ξ")
call DefineGreekLetter("Xi", "Ξ")
call DefineGreekLetter("omicron", "ο")
call DefineGreekLetter("Omicron", "Ο")
call DefineGreekLetter("pi", "π")
call DefineGreekLetter("Pi", "Π")
call DefineGreekLetter("rho", "ρ")
call DefineGreekLetter("Rho", "Ρ")
call DefineGreekLetter("sigma", "σ")
call DefineGreekLetter("Sigma", "Σ")
call DefineGreekLetter("tau", "τ")
call DefineGreekLetter("Tau", "Τ")
call DefineGreekLetter("upsilon", "υ")
call DefineGreekLetter("Upsilon", "Υ")
call DefineGreekLetter("phi", "φ")
call DefineGreekLetter("Phi", "Φ")
call DefineGreekLetter("chi", "χ")
call DefineGreekLetter("Chi", "Χ")
call DefineGreekLetter("psi", "ψ")
call DefineGreekLetter("Psi", "Ψ")
call DefineGreekLetter("omega", "ω")
call DefineGreekLetter("Omega", "Ω")

delf DefineGreekLetter
